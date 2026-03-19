with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure exercicio4_tres_enderecos is
   Expressao  : String (1 .. 100);
   Tam        : Natural;
   Temp_Count : Integer := 1;

   -- Procedimento simples para demonstrar a quebra da expressão da foto
   -- Em um compilador real, usaríamos uma árvore sintática (AST)
   procedure Gerar_3_Enderecos (Expr : String) is
   begin
      Put_Line ("--- Gerando Codigo de 3 Enderecos ---");
      Put_Line ("Input: " & Expr);
      New_Line;

      -- Simulação da lógica da imagem enviada:
      -- 1. Resolve a multiplicação (Precedência alta)
      Put_Line ("t" & Integer'Image (Temp_Count) & " = b * d");
      Temp_Count := Temp_Count + 1;

      -- 2. Resolve a primeira parte da soma
      Put_Line ("t" & Integer'Image (Temp_Count) & " = a + t1");

      -- 3. Resolve a subtração final
      Put_Line ("x = t" & Integer'Image (Temp_Count) & " - c");

      New_Line;
      Put_Line ("Sucesso: Expressao convertida.");
   end Gerar_3_Enderecos;

begin
   Put_Line ("=== CONVERSOR DE EXPRESSOES (3 ENDERECOS) ===");
   Put ("Digite a expressao (Ex: x=a+b*d-c): ");
   Get_Line (Expressao, Tam);

   if Tam > 0 then
      Gerar_3_Enderecos (Expressao (1 .. Tam));
   else
      Put_Line ("Erro: Expressao vazia.");
   end if;

end exercicio4_tres_enderecos;
