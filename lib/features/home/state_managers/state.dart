class UserState {
  final String email;
  final String phoneNumber;
  final String aboutUser;
  final String userImage;
  final bool isLoading;
  final int selectedIndex;

  UserState({
    required this.email,
    required this.phoneNumber,
    required this.aboutUser,
    required this.userImage,
    required this.isLoading,
    required this.selectedIndex,
  });

  UserState copyWith({
    String? email,
    String? phoneNumber,
    String? aboutUser,
    String? userImage,
    bool? isLoading,
    int? selectedIndex,
  }) {
    return UserState(
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      aboutUser: aboutUser ?? this.aboutUser,
      userImage: userImage ?? this.userImage,
      isLoading: isLoading ?? this.isLoading,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  List<Object> get props => [
        email,
        phoneNumber,
        aboutUser,
        userImage,
        isLoading,
        selectedIndex,
      ];

  factory UserState.initial() {
    return UserState(
      email: '',
      phoneNumber: '',
      aboutUser: '',
      userImage: 'assets/images/default_photo.jpg',
      isLoading: false,
      selectedIndex: 0,
    );
  }
}
