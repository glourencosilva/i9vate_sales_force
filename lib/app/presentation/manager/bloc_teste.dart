// import 'package:rxdart/streams.dart';
// import 'package:rxdart/subjects.dart';

// //https://pub.dev/packages/distinct_value_connectable_stream
// class BlocTeste<Action, State> {
//   final void Function(Action) dispatch;
//   final ValueStream<State> state;
//   final void Function() dispose;
//   BlocTeste._(
//     this.dispatch,
//     this.state,
//     this.dispose,
//   );

//   factory BlocTeste() {
//     final actions = PublishSubject<Action>();
//     final states = BehaviorSubject.seeded(State.initial());
//     final subscription = actions
//         .transform(ActionToStateTransform<Action, State>())
//         .listen((newState) {
//       if (states.value != newState) {
//         states.add(newState);
//       }
//     }, onError: states.addError);
//     return BlocTeste._(actions.add, states, () async {
//       await subscription.cancel();
//       await actions.close();
//       await states.close();
//     });
//   }
// }
