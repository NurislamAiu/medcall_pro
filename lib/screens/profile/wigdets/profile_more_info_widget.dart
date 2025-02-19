import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/color_screen.dart';

class ProfileMoreInfo extends StatelessWidget {
  final Map<String, dynamic>? data;

  ProfileMoreInfo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user?.uid ?? "";

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoCard(
              context: context,
              icon: Iconsax.location,
              title: "Address",
              value: data?['address'] ?? "Not Available",
              userId: userId,
            ),
            buildInfoCard(
              context: context,
              icon: Iconsax.calendar,
              title: "Age",
              value: data?['age']?.toString() ?? "Not Available",
            ),
            buildInfoCard(
              context: context,
              icon: Iconsax.man,
              title: "Gender",
              value: data?['gender']?.toString() ?? "Not Available",
            ),
            buildInfoCard(
              context: context,
              icon: Iconsax.mobile,
              title: "Phone",
              value: data?['phone']?.toString() ?? "Not Available",
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildInfoCard({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String value,
  String? userId,
}) {
  return ListTile(
    leading: Icon(icon, color: ScreenColor.color1),
    title: Text(title,
        style:
            TextStyle(fontWeight: FontWeight.bold, color: ScreenColor.color6)),
    subtitle: Text(value, style: TextStyle(color: Colors.grey[700])),
    trailing: title == "Address" && userId != null
        ? IconButton(
            icon: Icon(Icons.edit_location_alt_outlined,
                color: ScreenColor.color6, size: 26),
            onPressed: () => _showAddressEditModal(context, userId),
          )
        : null,
  );
}

void _showAddressEditModal(BuildContext context, String userId) {
  TextEditingController streetController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: EdgeInsets.only(top: 10, bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Center(
              child: Text(
                "Edit Address",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 20),
            _buildTextField(streetController, Icons.location_on_outlined,
                "Street", "Enter street name"),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(

                    child: _buildTextField(numberController,
                        Icons.house_outlined, "Number", "Enter house number",
                        isNumber: true)),
                SizedBox(width: 20),
                Expanded(

                    child: _buildTextField(
                        apartmentController,
                        Icons.apartment_outlined,
                        "Apartment",
                        "Enter apartment number")),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: ScreenColor.color6,
                ),
                onPressed: () async {
                  String newAddress =
                      "${streetController.text}, ${numberController.text}, ${apartmentController.text}";
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .update({'address': newAddress});
                  Navigator.pop(context);
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}

Widget _buildTextField(
    TextEditingController controller, IconData icon, String label, String hint,
    {bool isNumber = false}) {
  return TextField(
    controller: controller,
    keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    inputFormatters: isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: ScreenColor.color6),
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ScreenColor.color6, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ScreenColor.color6, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ScreenColor.color6, width: 1),
      ),
      labelStyle: TextStyle(color: ScreenColor.color1),
    ),
  );
}
