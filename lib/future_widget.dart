part of 'smart_autocomplete.dart';

class FutureWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot)
      loading;
  final Widget Function(BuildContext context, Object error) error;
  final Widget Function(BuildContext context, T data) data;

  const FutureWidget({
    super.key,
    required this.future,
    required this.loading,
    required this.error,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading(context, snapshot);
        } else if (snapshot.hasError) {
          return error(context, snapshot.error!);
        } else if (snapshot.hasData) {
          return data(context, snapshot.data as T);
        } else {
          // This case should never be reached, but we return an empty container just in case
          return Container();
        }
      },
    );
  }
}
