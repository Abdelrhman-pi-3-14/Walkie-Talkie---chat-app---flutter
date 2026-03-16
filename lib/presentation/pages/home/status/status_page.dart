// presentation/pages/home/status/status_page.dart
import 'package:flutter/material.dart';

import '../../../../constants/app_routes.dart';
import '../../../../data/services/pickImages/pick_image_service.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<MaterialColor> items = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
  ];

  final ImageService imageService = ImageService();


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(decoration: const BoxDecoration(color: Colors.white)),

          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: Center(
                      child: Text(items[index].toString().toUpperCase()),
                    ),
                  ),
                ),

              );
            },
          ),
          Positioned(
            bottom: 24,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: "fab2",
                  onPressed: () {
                     Navigator.pushNamed(context, AppRoutes.writeSomething);
                  },
                  backgroundColor: Color.fromARGB(255, 4, 59, 94),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/appIcons/pencil_icon.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 70,
                  child: FloatingActionButton(
                    backgroundColor: Color.fromARGB(255, 4, 59, 94),

                    heroTag: "fab1",
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    child: Image.asset(
                      "assets/images/camera.png",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _showBottomSheet(BuildContext context) {

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Close button
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, size: 20),
              ),
            ),
          ),

          GridView.count(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _mediaTile(
                icon: Icons.camera_alt,
                title: "Camera",
                onTap: () async {
                  final file = await imageService.pickFromCamera();

                  if(!mounted) return;
                  Navigator.pop(context);

                  if (file != null) {
                    debugPrint("Camera image: ${file.path}");
                  }
                },
              ),

              _mediaTile(
                icon: Icons.photo_library,
                title: "Gallery",
                onTap: () async {
                  final file = await imageService.pickFromGallery();

                  if(!mounted) return;
                  Navigator.pop(context);
                  if (file != null) {
                    debugPrint("Gallery image: ${file.path}");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _mediaTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36),
              const SizedBox(height: 12),
              Text(
                title.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }



}
