import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

class CreatePostScreen extends StatefulWidget {
  final Post? post; // Thêm biến post (nếu là cập nhật)

  const CreatePostScreen({super.key, this.post});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Nếu có dữ liệu post truyền vào thì gán giá trị mặc định cho form
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _submitData() async {
    if (_titleController.text.trim().isEmpty || _bodyController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng điền đầy đủ tiêu đề và nội dung!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      Post result;
      if (widget.post != null) {
        // Gọi API PUT cập nhật
        result = await _apiService.updatePost(
          widget.post!.id,
          _titleController.text,
          _bodyController.text,
        );
      } else {
        // Gọi API POST tạo mới
        result = await _apiService.createPost(
          _titleController.text,
          _bodyController.text,
        );
      }

      // Thành công, đóng màn hình và trả đối tượng Post về HomeScreen
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.post != null ? 'Cập nhật bài viết thành công!' : 'Tạo bài viết thành công!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, result);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', '')), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.post != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Cập nhật bài viết' : 'Thêm bài viết mới')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Tiêu đề', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Nội dung', border: OutlineInputBorder()),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _submitData,
              child: Text(isEditing ? 'Cập nhật' : 'Gửi dữ liệu'),
            )
          ],
        ),
      ),
    );
  }
}