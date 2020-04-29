import '../../flutter_neumorphic.dart';
import 'rrect_path_provider.dart';

class StadiumPathProvider extends RRectPathProvider {
  const StadiumPathProvider({Listenable reclip})
      : super(
            const BorderRadius.all(
              const Radius.circular(1000),
            ),
            reclip: reclip);
}
