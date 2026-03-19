with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure exercicio3_fibonacci is
   -- Variáveis para o cálculo
   A : Integer := 0;
   B : Integer := 1;
   Proximo : Integer;
begin
   Put_Line ("=== SEQUENCIA DE FIBONACCI (11 PRIMEIROS) ===");
   New_Line;

   for I in 1 .. 11 loop
      -- 1. Mostra o número atual (A)
      Put (A, Width => 4);
      
      -- 2. Lógica de Fibonacci: O próximo é a soma dos dois anteriores
      Proximo := A + B;
      A := B;       -- O segundo vira o primeiro
      B := Proximo; -- A soma vira o segundo
      
      -- Adiciona uma vírgula entre os números, exceto no último
      if I < 11 then
         Put (", ");
      end if;
   end loop;

   New_Line;
   Put_Line ("Fim da sequencia.");
end exercicio3_fibonacci;