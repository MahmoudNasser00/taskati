part of 'task_model.dart';

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    return TaskModel(
      title: reader.readString(),
      description: reader.readString(),
      date: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      startTime: reader.readString(),
      endTime: reader.readString(),
      color: reader.readInt(),
      isCompleted: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeString(obj.startTime);
    writer.writeString(obj.endTime);
    writer.writeInt(obj.color);
    writer.writeBool(obj.isCompleted);
  }
}