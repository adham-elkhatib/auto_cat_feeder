import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Data/Model/Cat/cat.model.dart';
import '../../../../Data/Model/Cat/feeder_model.dart';
import '../../../../Data/Model/Cat/meal.model.dart';
import '../../../../Data/Repositories/cat_repo.dart';
import '../../../../Data/Repositories/feeder_repo.dart';
import '../../../../core/Services/Auth/auth.service.dart';
import '../../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../../../../core/Services/FCM Notification/fcm.notification.service.dart';
import '../../../../core/Services/Id Generating/id_generating.service.dart';
import '../../../../core/utils/SnackBar/snackbar.helper.dart';
import '../../../Profile/pages/profile.screen.dart';
import '../widgets/ai_insights_card.dart';
import '../widgets/delete_meal_alert_dialog.dart';
import '../widgets/edit_pet_profile.dart';
import '../widgets/edit_serving_alert_dialog.dart';
import '../widgets/feeder_connection.dart';
import '../widgets/feeder_management_card.dart';
import '../widgets/info_card.dart';
import '../widgets/schedule_card.dart';
import 'live_camera_feed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<(Cat?, FeederModel?)> _homeData;

  @override
  void initState() {
    super.initState();
    _homeData = _loadHomeData();
  }

  Future<(Cat?, FeederModel?)> _loadHomeData() async {
    final userId = AuthService(
      authProvider: FirebaseAuthProvider(firebaseAuth: FirebaseAuth.instance),
    ).getCurrentUserId();

    if (userId == null) return (null, null);

    final cat = await CatRepo().readSingle(userId);
    if (cat == null || cat.feederId == null) return (null, null);

    final feeder = await FeederRepo().read(cat.feederId!);

    final token = FCMNotification.getFcmToken();

    if (feeder != null && token != null) {
      final updatedFeeder = feeder.copyWith(token: token);
      await FeederRepo().update(feeder.id, updatedFeeder);
      return (cat, updatedFeeder);
    }

    return (cat, feeder);
  }

  Future<void> _showEditPetProfileBottomSheet(
      BuildContext context, Cat pet) async {
    final updatedPet = await showModalBottomSheet<Cat>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => EditPetProfile(pet: pet),
    );

    if (updatedPet != null) {
      await CatRepo().updateSingle(updatedPet.id, updatedPet);
      final oldFeeder = (await _homeData).$2;

      setState(() {
        _homeData = Future.value((updatedPet, oldFeeder));
      });
    }
  }

  Future<void> _showDeleteMealDialog(
      BuildContext context, FeederModel feeder, int index, Cat pet) {
    return showDialog<void>(
      context: context,
      builder: (context) => DeleteMealAlertDialog(
        meal: feeder.meals[index],
        onDelete: () async {
          final updatedMeals = List<Meal>.from(feeder.meals)..removeAt(index);
          final updatedFeeder = feeder.copyWith(meals: updatedMeals);
          await FeederRepo().update(feeder.id, updatedFeeder);
          setState(() {
            _homeData = Future.value((pet, updatedFeeder));
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome back 👋'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_2_outlined,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<(Cat?, FeederModel?)>(
        future: _homeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final cat = snapshot.data?.$1;
          final feeder = snapshot.data?.$2;

          if (cat == null || feeder == null) {
            return const Center(child: Text("No data found."));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoCard(
                  cat: cat,
                  numberOfMeals: feeder.meals.length,
                  onOpenSheet: () =>
                      _showEditPetProfileBottomSheet(context, cat),
                ),
                const SizedBox(height: 16),
                AIInsightsCard(
                  cat: cat,
                ),
                const SizedBox(height: 16),
                FeederManagementCard(
                  isConnected: true,
                  hasFood: true,
                  feeder: feeder,
                  onOpenSheet: () => _showFeederBottomSheet(context),
                ),
                const SizedBox(height: 24),
                Text(
                  "Scheduled meals",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 16),
                if (feeder.meals.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.event_busy_outlined,
                            size: 44,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        const SizedBox(height: 8),
                        Text(
                          "No meals scheduled yet",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    children: List.generate(
                      feeder.meals.length,
                      (index) => ScheduleCard(
                        meal: feeder.meals[index],
                        onToggle: (value) async {
                          final updatedMeals = List<Meal>.from(feeder.meals);
                          updatedMeals[index] = feeder.meals[index].copyWith(
                            isEnabled: !feeder.meals[index].isEnabled,
                          );
                          final updatedFeeder =
                              feeder.copyWith(meals: updatedMeals);
                          await FeederRepo().update(feeder.id, updatedFeeder);
                          setState(() {
                            _homeData = Future.value((cat, updatedFeeder));
                          });
                        },
                        onDelete: () async {
                          await _showDeleteMealDialog(
                              context, feeder, index, cat);
                        },
                        onEditServing: () async {
                          final updatedMeal = await showDialog<Meal>(
                            context: context,
                            builder: (context) => EditServingAlertDialog(
                                meal: feeder.meals[index]),
                          );

                          if (updatedMeal != null) {
                            final updatedMeals = List<Meal>.from(feeder.meals);
                            updatedMeals[index] = updatedMeal;
                            final updatedFeeder =
                                feeder.copyWith(meals: updatedMeals);
                            await FeederRepo().update(feeder.id, updatedFeeder);
                            setState(() {
                              _homeData = Future.value((cat, updatedFeeder));
                            });
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FutureBuilder<(Cat?, FeederModel?)>(
        future: _homeData,
        builder: (context, snapshot) {
          final feeder = snapshot.data?.$2;
          final cat = snapshot.data?.$1;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => LiveCameraFeed(
                        ip: feeder!.ipAddress,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 24,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 🔸 زر إضافة ميعاد وجبة
              GestureDetector(
                onTap: () async {
                  if (feeder == null || cat == null) {
                    SnackbarHelper.showError(context,
                        title: "Feeder not found");
                    return;
                  }

                  String mealId = IdGeneratingService.generate();
                  TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (time != null) {
                    final now = DateTime.now();
                    final selectedDateTime = DateTime(
                      now.year,
                      now.month,
                      now.day,
                      time.hour,
                      time.minute,
                    );

                    // طرح timezone offset
                    final adjustedDateTime =
                        selectedDateTime.subtract(now.timeZoneOffset);
                    final adjustedTime = TimeOfDay(
                      hour: adjustedDateTime.hour,
                      minute: adjustedDateTime.minute,
                    );

                    final updatedMeals = List<Meal>.from(feeder.meals)
                      ..add(
                        Meal(
                          id: mealId,
                          serving: 0,
                          time: adjustedTime,
                          isEnabled: true,
                        ),
                      );

                    final updatedFeeder = feeder.copyWith(meals: updatedMeals);
                    await FeederRepo().update(feeder.id, updatedFeeder);
                    setState(() {
                      _homeData = Future.value((cat, updatedFeeder));
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(22),
                  child: Icon(
                    Icons.add,
                    size: 36,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showFeederBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const FeederConnectionPage(),
    );
  }
}
