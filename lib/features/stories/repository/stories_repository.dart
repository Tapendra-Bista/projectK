import 'package:afriqueen/common/constant/constant_strings.dart';
import 'package:afriqueen/features/stories/model/stories_model.dart';
import 'package:afriqueen/services/base_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

class StoriesRepository extends BaseRepository {
  final cloudinary = CloudinaryPublic(
    AppStrings.cloudName,
    AppStrings.uploadPreset,
  );

  final ImagePicker _imagePicker = ImagePicker();
  StoriesRepository({FirebaseFirestore? fire});

  //--------------------------------Image adding to cloudinary-----------------------------
  Future<String?> addStoriesImageToCloudinary() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            image.path,
            resourceType: CloudinaryResourceType.Image,
            folder: "afriqueen/stories",
            publicId: "${DateTime.now().millisecondsSinceEpoch}",
          ),
        );
        return response.secureUrl;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  //-------------------------- Upload or update user story in Firestore --------------------------
  Future<void> uploadStoriesToFirebase(StoriesModel model) async {
    final docRef = firestore.collection('stories').doc(model.uid);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      // First time: create new document
      await docRef.set({
        'id': model.uid,
        'containUrl': model.containUrl,
        'createdDate': model.createdDate,
        'userName': model.userName,
        'userImg': model.userImg,
      });
    } else {
      // Existing story: update containUrl and createdDate arrays
      await docRef.update({
        'containUrl': FieldValue.arrayUnion(model.containUrl),
        'createdDate': FieldValue.arrayUnion(model.createdDate),
      });
    }
  }

  //-------------------------- Fetch all stories --------------------------
  Future<List<StoriesFetchModel>> fetchAllStoriesData() async {
    try {
      final snapshot = await firestore.collection('stories').get();

      return snapshot.docs.map((doc) {
        return StoriesFetchModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      print("Error fetching stories: $e");
      rethrow;
    }
  }
}
