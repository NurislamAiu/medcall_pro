import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/color_screen.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/custom_text_filed.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController iinController;
  final TextEditingController ageController;
  final TextEditingController phoneController;
  final TextEditingController certificateController;
  final String gender;
  final Function(String) onGenderChanged;

  const RegisterForm({
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.iinController,
    required this.ageController,
    required this.phoneController,
    required this.certificateController,
    required this.gender,
    required this.onGenderChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late String _gender;

  @override
  void initState() {
    super.initState();
    _gender = widget.gender;
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: widget.emailController,
          label: 'Email',
          icon: Iconsax.sms,
          validator: Validators.emailValidator,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: widget.passwordController,
          obscureText: true,
          label: 'Пароль',
          icon: Iconsax.lock,
          validator: Validators.passwordValidator,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: widget.nameController,
          label: 'Ф.И.О',
          icon: Iconsax.user,
          validator: Validators.nameValidator,
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: widget.certificateController,
          label: 'Номер Сертификата',
          icon: Iconsax.note,
          validator: Validators.nameValidator,
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomTextField(
                controller: widget.iinController,
                label: 'ИИН',
                icon: Iconsax.text_block,
                validator: Validators.iinValidator,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: CustomTextField(
                controller: widget.ageController,
                label: 'Возраст',
                icon: Iconsax.calendar,
                type: TextInputType.number,
                validator: Validators.ageValidator,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        CustomTextField(
          controller: widget.phoneController,
          label: 'Телефон',
          icon: Iconsax.mobile,
          type: TextInputType.phone,
          inputFormatters: [
            MaskedInputFormatter('+# (###) ###-##-##'),
          ],
          validator: Validators.phoneValidator,
        ),
        SizedBox(height: 20),
        _buildGenderSelection(),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(Iconsax.aquarius,
                  color: ScreenColor.color1.withOpacity(0.5)),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: _gender,
                borderRadius: BorderRadius.circular(10),
                dropdownColor: Colors.white,
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue!;
                    widget.onGenderChanged(_gender);
                  });
                },
                items: ['Не выбран', 'Мужчина', 'Женщина']
                    .map((value) =>
                        DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                underline: SizedBox(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
