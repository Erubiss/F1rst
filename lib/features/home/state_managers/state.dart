// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserState {
  final String email;
  final String phoneNumber;
  final String aboutUser;
  final String userImage;
  final bool isLoading;
  final int selectedIndex;
  final List<String> homeGrids;

  UserState({
    required this.email,
    required this.phoneNumber,
    required this.aboutUser,
    required this.userImage,
    required this.isLoading,
    required this.selectedIndex,
    required this.homeGrids,
  });

  UserState copyWith({
    String? email,
    String? phoneNumber,
    String? aboutUser,
    String? userImage,
    bool? isLoading,
    int? selectedIndex,
    List<String>? homeGrids,
  }) {
    return UserState(
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      aboutUser: aboutUser ?? this.aboutUser,
      userImage: userImage ?? this.userImage,
      isLoading: isLoading ?? this.isLoading,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      homeGrids: homeGrids ?? this.homeGrids,
    );
  }

  List<Object> get props => [
        email,
        phoneNumber,
        aboutUser,
        userImage,
        isLoading,
        selectedIndex,
        homeGrids,
      ];

  factory UserState.initial() {
    return UserState(
      email: '',
      phoneNumber: '',
      aboutUser: '',
      userImage: '',
      isLoading: false,
      selectedIndex: 0,
      homeGrids: [
        'a',
      ],
    );
  }

}
