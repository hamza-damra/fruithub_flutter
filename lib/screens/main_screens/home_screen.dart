import 'package:flutter/material.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/search/search_delegate.dart';
import 'package:fruitshub/widgets/most_selling_builder.dart';
import 'package:fruitshub/widgets/search.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedOption;
  String sortDirection = 'dasc';
  String sortBy = 'name';

  void reBuild() {
    setState(() {});
  }

  String name = '';

  void getUserName() async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(
      await SharedPrefManager().getData('token'),
    );

    setState(() {
      name = decodedToken['name'];
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '..! صباح الخير',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                    fontSize: .05 * screenWidth,
                  ),
                ),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: .05 * screenWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: CircleAvatar(
              radius: screenWidth * 0.07, // Responsive radius
              backgroundImage: const AssetImage('assets/images/avatar.jpg'),
            ),
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 220, 228, 221),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
              ),
              onPressed: () {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message: "سيتم توفير الاشعارات قريبا",
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              color: const Color.fromARGB(255, 39, 139, 43),
              iconSize: screenWidth * 0.07,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.01), // Responsive spacing
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: Searchdelegate(),
              );
            },
            child: SearchHeader(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              textScaleFactor: textScaleFactor,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 17),
                            const Padding(
                              padding: EdgeInsets.only(right: 13.0),
                              child: Text(
                                ': ترتيب حسب',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            RadioListTile<String>(
                              title: const Text(
                                'السعر ( الأقل الي الأعلي )',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              value: 'asc',
                              groupValue: _selectedOption,
                              activeColor: Colors.green.shade600,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedOption = value;
                                  sortDirection = 'asc';
                                  sortBy = 'price';
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text(
                                'السعر ( الأعلي الي الأقل )',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              value: 'desc',
                              groupValue: _selectedOption,
                              activeColor: Colors.green.shade600,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedOption = value;
                                  sortDirection = 'desc';
                                  sortBy = 'price';
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text(
                                'الأبجديه',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              value: 'name',
                              groupValue: _selectedOption,
                              activeColor: Colors.green.shade600,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedOption = value;
                                  sortDirection = 'desc';
                                  sortBy = 'name';
                                });
                              },
                            ),
                            const SizedBox(height: 9),
                            Center(
                              child: SizedBox(
                                width: screenWidth * 0.90,
                                height: 40,
                                child: ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Color(0xff1B5E37),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    reBuild(); // Call sort function
                                  },
                                  child: const Text(
                                    'تصفيه',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 7),
          MostSellingBuilder(
            showText: true,
            sortDirection: sortDirection,
            sortBy: sortBy,
          ),
        ],
      ),
    );
  }
}
