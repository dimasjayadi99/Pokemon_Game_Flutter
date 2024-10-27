import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/text_formatter.dart';

class DetailImage
{
  Widget buildImageCard(BuildContext context, String name ,String imageUrl, String version) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                showZoomedImage(context, imageUrl);
              },
              child: ClipOval(
                child: imageUrl.endsWith(".svg") ? SvgPicture.network(
                  imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ) : Image.network(
                  imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: [
                Text(
                  TextFormatter().capitalize(name),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  version,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showZoomedImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: 400,
            height: 400,
            child: imageUrl.endsWith('.svg') ? SvgPicture.network(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ) :  Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}