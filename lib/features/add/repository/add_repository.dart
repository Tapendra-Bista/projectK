import 'package:afriqueen/common/constant/constant_strings.dart';
import 'package:afriqueen/features/reels/model/reel_model.dart';
import 'package:afriqueen/services/base_repository.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

class AddRepository extends BaseRepository {
  final ImagePicker imagePicker = ImagePicker();
//------------------------Pick Video (reels) From Gallery----------------
  Future<String?> videoPicker() async {
    try {
      final XFile? video = await imagePicker.pickVideo(
          source: ImageSource.gallery, maxDuration: Duration(seconds: 15));

      if (video != null) return video.path;
    } catch (e) {
      rethrow;
    }
    return null;
  }

//--------------------Upload reels to Cloudinary---------------------
  Future<String> postVideoInCloudinary(String videoPath) async {
    try {
      final CloudinaryPublic cloudinary =
          CloudinaryPublic(AppStrings.cloudName, AppStrings.uploadPreset);
      final CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          videoPath,
          resourceType: CloudinaryResourceType.Video,
          folder: "afriqueen/reels",
          publicId: "${DateTime.now().millisecond}",
        ),
      );
      print("Reels video Url is ${response.secureUrl}");
      return response.secureUrl;
    } catch (e) {
      rethrow;
    }
  }

//------------------create ----------
  Future<void> addToFirebase(ReelModel reelmodel) async {
    await firestore.collection('reels').doc().set(reelmodel.toMap());
  }
}
