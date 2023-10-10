import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:semana_academica/controllers/register_controller.dart';
import 'package:semana_academica/services/products_service.dart';

class RegisterProduct extends StatefulWidget {
  const RegisterProduct({Key? key}) : super(key: key);

  @override
  _RegisterProductState createState() => _RegisterProductState();
}

class _RegisterProductState extends State<RegisterProduct> {
  //KeyForm
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Register a new product',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),

              //Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      title: 'Name',
                      hintText: 'Enter a name',
                      controller: _controller.nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      title: 'Image',
                      hintText: 'Enter a image',
                      controller: _controller.imageController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      title: 'Price',
                      hintText: 'Enter a price',
                      isNumber: true,
                      controller: _controller.priceController,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    //Validate form
                    if (_formKey.currentState!.validate()) {
                      await ProductsService().addProduct({
                        'name': _controller.nameController.text,
                        'image': _controller.imageController.text,
                        'price': _controller.priceController.text,
                      });
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),
              Center(child: Lottie.asset('assets/empty.json', height: 250)),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.hintText,
    this.isNumber,
    required this.controller,
  });

  final String title;
  final String hintText;
  final bool? isNumber;
  final TextEditingController controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            counterText: '',
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            contentPadding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
          ),
          keyboardType: widget.isNumber == true
              ? TextInputType.number
              : TextInputType.text,
          textAlignVertical: TextAlignVertical.center,
          autocorrect: false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            //Validations required field
            if (value != null && value.isEmpty) {
              return 'Required field';
            }

            return null;
          },
        ),
      ],
    );
  }
}
