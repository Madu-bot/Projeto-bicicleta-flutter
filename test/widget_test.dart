// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:contador_bicicleta_pibic/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verifica que o contador começa em zero
    expect(find.text('Rotações: 0'), findsOneWidget, reason: 'O contador deve iniciar em zero');
    expect(find.text('Rotações: 1'), findsNothing, reason: 'O contador não deve iniciar em um');

    // Verifica se o botão existe antes de clicar
    final botaoGirar = find.text('GIRAR RODA');
    expect(botaoGirar, findsOneWidget, reason: 'O botão GIRAR RODA deve estar presente na tela');

    // Simula o clique no botão "GIRAR RODA"
    await tester.tap(botaoGirar);
    await tester.pumpAndSettle();

    // Verifica que o contador incrementou
    expect(find.text('Rotações: 0'), findsNothing, reason: 'O texto Rotações: 0 não deve aparecer após o clique');
    expect(find.text('Rotações: 1'), findsOneWidget, reason: 'O contador deve ser incrementado para 1');
  });
}
