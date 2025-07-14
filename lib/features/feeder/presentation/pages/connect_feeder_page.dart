// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/utils/SnackBar/snackbar.helper.dart';
// import '../../../cat_profile/domain/entities/cat_entity.dart';
// import '../../../home/presentation/pages/home_screen.dart';
// import '../providers/feeder_bloc.dart';
// import '../widgets/barcode_info_section.dart';
// import '../widgets/scan_button.dart';
//
// class ConnectFeederPage extends StatefulWidget {
//   final CatEntity cat;
//
//   const ConnectFeederPage({super.key, required this.cat});
//
//   @override
//   State<ConnectFeederPage> createState() => _ConnectFeederPageState();
// }
//
// class _ConnectFeederPageState extends State<ConnectFeederPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<FeederBloc, FeederState>(
//       listener: (context, state) {
//         if (state is FeederConnectionSuccess) {
//           SnackbarHelper.showTemplated(
//             context,
//             title: 'Feeder connected successfully.',
//           );
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute<void>(
//               builder: (_) => const HomeScreen(),
//             ),
//             (_) => false,
//           );
//         }
//         if (state is FeederError) {
//           SnackbarHelper.showError(context, title: state.message);
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Connect your feeder"),
//         ),
//         body: const BarcodeInfoSection(),
//         bottomNavigationBar: ScanButton(
//           onScan: () {
//             context
//                 .read<FeederBloc>()
//                 .add(ConnectFeederRequested(cat: widget.cat));
//           },
//         ),
//       ),
//     );
//   }
// }
