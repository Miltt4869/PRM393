import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainNavigatorScreen(),
    );
  }
}

// ==========================================
// DATA MODELS & HARDCODED DATA
// ==========================================
class User {
  final String name;
  final String avatarUrl;
  final bool isActive;

  User({required this.name, required this.avatarUrl, this.isActive = false});
}

class ChatMessage {
  final User sender;
  final String lastMessage;
  final String time;
  final bool isUnread;

  ChatMessage({
    required this.sender,
    required this.lastMessage,
    required this.time,
    this.isUnread = false,
  });
}

final User currentUser = User(
  name: "Tôi",
  avatarUrl: "https://picsum.photos/id/1005/150/150",
);

final List<User> activeUsers = [
  User(name: "Friend Anh", avatarUrl: "https://picsum.photos/id/1011/150/150", isActive: true),
  User(name: "Friend Bằng", avatarUrl: "https://picsum.photos/id/1012/150/150", isActive: true),
  User(name: "Friend Sơn", avatarUrl: "https://picsum.photos/id/1027/150/150", isActive: true),
  User(name: "Friend Trí", avatarUrl: "https://picsum.photos/id/64/150/150", isActive: true),
  User(name: "Friend Mii", avatarUrl: "https://picsum.photos/id/65/150/150", isActive: true),
  User(name: "Friend Tài", avatarUrl: "https://picsum.photos/id/338/150/150", isActive: true),
  User(name: "Friend Q", avatarUrl: "https://picsum.photos/id/342/150/150", isActive: true),
  User(name: "Friend L", avatarUrl: "https://picsum.photos/id/349/150/150", isActive: true),
];

final List<ChatMessage> allChats = [
  ChatMessage(
    sender: User(name: "Anh", avatarUrl: "https://picsum.photos/id/1011/150/150"),
    lastMessage: "Bạn: Hiiii bạn",
    time: "07:20",
    isUnread: true,
  ),
  ChatMessage(
    sender: User(name: "Phương Linh", avatarUrl: "https://picsum.photos/id/447/150/150"),
    lastMessage: "Bạn đã gửi một file đính kèm",
    time: "07:18",
  ),
  ChatMessage(
    sender: User(name: "Yến", avatarUrl: "https://picsum.photos/id/445/150/150"),
    lastMessage: "Bạn đã gửi một nhãn dán.",
    time: "T.2",
  ),
  ChatMessage(
    sender: User(name: "2026 đi đâu", avatarUrl: "https://picsum.photos/id/453/150/150"),
    lastMessage: "Friend 4: tiếng nhật ...",
    time: "T.2",
    isUnread: true,
  ),
  ChatMessage(
    sender: User(name: "Tam Ca", avatarUrl: "https://picsum.photos/id/449/150/150"),
    lastMessage: "Friend đã gửi một file đính kèm.",
    time: "T.6",
  ),
  ////////
  ChatMessage(
    sender: User(name: "Tuấn", avatarUrl: "https://picsum.photos/id/1011/150/150"),
    lastMessage: "Bạn: Hiiii bạn",
    time: "07:20",
    isUnread: true,
  ),
  ChatMessage(
    sender: User(name: "Phương", avatarUrl: "https://picsum.photos/id/447/150/150"),
    lastMessage: "Bạn đã gửi một file đính kèm",
    time: "07:18",
  ),
  ChatMessage(
    sender: User(name: "Hiền", avatarUrl: "https://picsum.photos/id/445/150/150"),
    lastMessage: "Bạn đã gửi một nhãn dán.",
    time: "06:09",
  ),
  ChatMessage(
    sender: User(name: "Friend 4", avatarUrl: "https://picsum.photos/id/453/150/150"),
    lastMessage: "Friend 4: Đâu rồi ...",
    time: "T.2",
    isUnread: true,
  ),
  ChatMessage(
    sender: User(name: "Hôm nay ăn gì", avatarUrl: "https://picsum.photos/id/449/150/150"),
    lastMessage: "Friend đã gửi một file đính kèm.",
    time: "T.6",
  ),
];
// ==========================================
// MAIN NAVIGATOR (Xử lý Bottom Navigation)
// ==========================================
class MainNavigatorScreen extends StatefulWidget {
  const MainNavigatorScreen({super.key});

  @override
  State<MainNavigatorScreen> createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình
  final List<Widget> _screens = [
    const ChatScreen(),
    const PeopleScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'People',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications),
          //   label: 'Thông báo',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.menu),
          //   label: 'Menu',
          // ),
        ],
      ),
    );
  }
}

// ==========================================
// 1. CHAT SCREEN (Màn hình chính)
// ==========================================
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // --- THUẬT TOÁN TÌM KIẾM MỚI ---
    List<User> searchResults = [];

    if (_searchQuery.isNotEmpty) {
      // 1. Gộp tất cả User từ 2 danh sách lại (Dùng Map để loại bỏ trùng lặp tên)
      Map<String, User> uniqueUsersMap = {};
      for (var u in activeUsers) {
        uniqueUsersMap[u.name] = u;
      }
      for (var c in allChats) {
        uniqueUsersMap[c.sender.name] = c.sender;
      }

      List<User> allUniqueUsers = uniqueUsersMap.values.toList();

      // 2. Lọc danh sách tổng hợp này theo từ khóa tìm kiếm
      searchResults = allUniqueUsers
          .where((user) => user.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return SafeArea(
      child: Column(
        children: [
          // --- APP BAR TÙY CHỈNH ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "messenger",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- KHUNG SEARCH ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Hỏi Meta AI hoặc tìm kiếm",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // --- KHUNG DANH SÁCH GỢI Ý (Chỉ hiện khi KHÔNG TÌM KIẾM) ---
          if (_searchQuery.isEmpty)
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: activeUsers.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildAddStoryItem();
                  }
                  return _buildActiveUserItem(activeUsers[index - 1]);
                },
              ),
            ),

          // --- DANH SÁCH CÁC CONTACT/BẠN ---
          Expanded(
            child: _searchQuery.isEmpty
            // TRƯỜNG HỢP 1: KHÔNG TÌM KIẾM -> HIỂN THỊ DANH SÁCH CHAT BÌNH THƯỜNG
                ? ListView.builder(
              itemCount: allChats.length,
              itemBuilder: (context, index) {
                final chat = allChats[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(chat.sender.avatarUrl),
                  ),
                  title: Text(
                    chat.sender.name,
                    style: TextStyle(
                      fontWeight: chat.isUnread ? FontWeight.bold : FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    chat.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: chat.isUnread ? FontWeight.bold : FontWeight.normal,
                      color: chat.isUnread ? Colors.black87 : Colors.grey.shade600,
                    ),
                  ),
                  trailing: Text(
                    chat.time,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  onTap: () {},
                );
              },
            )
            // TRƯỜNG HỢP 2: ĐANG TÌM KIẾM -> HIỂN THỊ KẾT QUẢ TỔNG HỢP
                : searchResults.isEmpty
                ? const Center(child: Text("Không tìm thấy kết quả"))
                : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final user = searchResults[index];

                // Kiểm tra xem người này có nằm trong danh sách đã chat không
                final chatIndex = allChats.indexWhere((c) => c.sender.name == user.name);

                if (chatIndex != -1) {
                  // A. NẾU ĐÃ TỪNG CHAT -> Hiển thị nội dung chat
                  final chat = allChats[chatIndex];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(chat.sender.avatarUrl),
                    ),
                    title: Text(
                      chat.sender.name,
                      style: TextStyle(
                        fontWeight: chat.isUnread ? FontWeight.bold : FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      chat.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: chat.isUnread ? FontWeight.bold : FontWeight.normal,
                        color: chat.isUnread ? Colors.black87 : Colors.grey.shade600,
                      ),
                    ),
                    trailing: Text(
                      chat.time,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    onTap: () {},
                  );
                } else {
                  // B. NẾU CHƯA TỪNG CHAT -> Hiển thị giống gợi ý liên hệ
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                    title: Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    subtitle: const Text("Bạn bè trên Facebook", style: TextStyle(color: Colors.grey)),
                    onTap: () {},
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị mục "Tạo tin"
  Widget _buildAddStoryItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(currentUser.avatarUrl),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.add, size: 18, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text("Tạo tin", style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  // Widget hiển thị User đang active
  Widget _buildActiveUserItem(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
              if (user.isActive)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            user.name,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
// ==========================================
// 2. PEOPLE SCREEN (Màn hình Danh bạ)
// ==========================================
class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Gom tất cả user lại để hiển thị danh bạ
    final List<User> allContacts = activeUsers + allChats.map((c) => c.sender).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mọi người", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: allContacts.length,
        itemBuilder: (context, index) {
          final contact = allContacts[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(contact.avatarUrl),
            ),
            title: Text(contact.name, style: const TextStyle(fontWeight: FontWeight.w500)),
            // Hiển thị nút vẫy tay hoặc gọi (tuỳ chọn thêm cho sinh động)
            trailing: IconButton(
              icon: const Icon(Icons.waving_hand, color: Colors.orange, size: 20),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}