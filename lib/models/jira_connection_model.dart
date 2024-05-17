class JiraConnectionModel {
  final String docId;
  final String userId;
  final String taskType;
  final String userName;
  final String apiKey;
  final String url;

  JiraConnectionModel(
      {this.docId = '',
      this.userId = '',
      this.taskType = '',
      this.userName = '',
      this.apiKey = '',
      this.url = ''});
}
