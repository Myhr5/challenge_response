class ValidateResponse {
  final String? id;
  final String message;
  final List<String>? errors;

  const ValidateResponse({
    required this.message,
    this.id = '',
    this.errors,
  });

  factory ValidateResponse.fromJson(Map<String, dynamic> json) =>
      ValidateResponse(
        id: json['id'] ?? '',
        message: json['message'],
        errors: List<String>.from(json['errors'] ?? ['']),
      );
}
