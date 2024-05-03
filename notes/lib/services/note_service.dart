import 'dart:js_interop';

class NoteService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _notesCollection =
      _database.collection('notes');

  //Menyimpan objek baru ke dalam collection
  static Future<void> addNote(String title, String description) async {
    Map<String, dynamic> newNote = {
      'title': title,
      'description': description,
    };
    await _notesCollection.add(newNote);
  }

  //Mengupdate objek baru ke dalam collection
  static Future<void> updateNote(String title, String description) async {
    Map<String, dynamic> updateNote = {
      'title': title,
      'description': description,
    };
    await _notesCollection.doc(id).update(updateNote);
  }

  //Menghapus objek
  static Future<void> deleteNote(String id) async {
     await _notesCollection.doc(id).delete();
}

//retrieve objek
  static Future<QuerySnapshot> retrieveNotes() {
    return _notesCollection.get();
  }

//get notes dalam bentuk list (array)
  static Stream<List<Map<String, dynamic>>> getNotesList(){
    return _notesCollection.snapshots().map((querySnapshot)) {
      return querySnapshot.docs.map((docSnapshot) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return {'id': docSnapshot.id, ...data};
      }).toList();
    };
  }