import 'package:powersync/powersync.dart';
import 'package:powersync_attachments_helper/powersync_attachments_helper.dart';

//const todosTable = 'todos';

// Schema schema = Schema(([
//   const Table(todosTable, [
//     Column.text('list_id'),
//     Column.text('photo_id'),
//     Column.text('created_at'),
//     Column.text('completed_at'),
//     Column.text('description'),
//     Column.integer('completed'),
//     Column.text('created_by'),
//     Column.text('completed_by'),
//   ], indexes: [
//     // Index to allow efficient lookup within a list
//     Index('list', [IndexedColumn('list_id')])
//   ]),
//   const Table('lists', [
//     Column.text('created_at'),
//     Column.text('name'),
//     Column.text('owner_id')
//   ]),
//   AttachmentsQueueTable(
//       attachmentsQueueTableName: defaultAttachmentsQueueTableName)
// ]));// Schema schema = Schema(([
// //   const Table(todosTable, [
// //     Column.text('list_id'),
// //     Column.text('photo_id'),
// //     Column.text('created_at'),
// //     Column.text('completed_at'),
// //     Column.text('description'),
// //     Column.integer('completed'),
// //     Column.text('created_by'),
// //     Column.text('completed_by'),
// //   ], indexes: [
// //     // Index to allow efficient lookup within a list
// //     Index('list', [IndexedColumn('list_id')])
// //   ]),
// //   const Table('lists', [
// //     Column.text('created_at'),
// //     Column.text('name'),
// //     Column.text('owner_id')
// //   ]),
// //   AttachmentsQueueTable(
// //       attachmentsQueueTableName: defaultAttachmentsQueueTableName)
// // ]));


/// schema for TaskRM ///

const schema = Schema([
  Table('feed', [
    Column.text('created_at'),
    Column.text('updated_at'),
    Column.text('user_id'),
    Column.text('description'),
    Column.text('source'),
    Column.text('timestamp'),
    Column.integer('encrypted'),
    Column.text('image_url')
  ]),
  Table('goals', [
    Column.text('created_at'),
    Column.text('updated_at'),
    Column.text('title'),
    Column.text('user_id'),
    Column.text('description'),
    Column.text('type'),
    Column.text('parent_goal'),
    Column.integer('is_completed')
  ]),
  Table('jira_connections', [
    Column.text('created_at'),
    Column.text('updated_at'),
    Column.text('user_id'),
    Column.text('task_type'),
    Column.text('user_name'),
    Column.text('api_key'),
    Column.text('url')
  ]),
  Table('journal', [
    Column.text('created_at'),
    Column.text('updated_at'),
    Column.text('journal_text'),
    Column.text('user_id'),
    Column.text('image_url'),
    Column.integer('journal_type'),
    Column.integer('encrypted')
  ]),
  Table('moment_events', [
    Column.text('created_at'),
    Column.text('updated_at'),
    Column.text('moment'),
    Column.integer('amount'),
    Column.text('user_id'),
    Column.text('image_url')
  ]),
  Table('moment_types', [
    Column.text('created_at'),
    Column.text('updated_at'),
    Column.text('format'),
    Column.text('user_id'),
    Column.text('type'),
    Column.text('icon'),
    Column.text('name')
  ]),
  Table('tasks', [
    Column.text('created_at'),
    Column.text('updated_at'),
    Column.text('timeframe'),
    Column.text('jira_id'),
    Column.text('title'),
    Column.text('type'),
    Column.integer('is_marked_for_today'),
    Column.text('goal_id'),
    Column.text('priority'),
    Column.text('description'),
    Column.text('user_id'),
    Column.text('goal'),
    Column.text('expected_completion'),
    Column.integer('is_completed'),
    Column.integer('total_minutes_spent')
  ]),
  Table('time_tracking', [
    Column.text('created_at'),
    Column.text('updated_at'),
    Column.text('user_id'),
    Column.text('goal_id'),
    Column.text('task_id'),
    Column.text('entry_date'),
    Column.text('start_time'),
    Column.text('stop_time'),
    Column.text('time_spent')
  ]),
  Table('user_profile', [
    Column.text('created_at'),
    Column.text('updated_at'),
    Column.text('image_url'),
    Column.text('name'),
    Column.text('encryption_key'),
    Column.text('language'),
    Column.text('jira_user_name'),
    Column.text('jira_url'),
    Column.text('user_id'),
    Column.text('jira_key')
  ])
]);

