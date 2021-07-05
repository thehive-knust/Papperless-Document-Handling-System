class Doc {
  String status;
  Doc(this.status);

  static List<Map<String, List<Doc>>> get docs => [
        {
          "Today": [
            Doc('in progress'),
            Doc("in progress"),
            Doc("approved"),
          ],
        },
        {
          "Yesturday": [
            Doc("rejected"),
            Doc("in progress"),
            Doc("in progress"),
            Doc("approved"),
          ],
        },
        {
          "Last Week": [
            Doc("approved"),
            Doc("approved"),
            Doc("rejected"),
            Doc("approved"),
          ]
        }
      ];
}
