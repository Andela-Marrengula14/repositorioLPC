with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Characters.Handling;  use Ada.Characters.Handling;
with Ada.Strings.Unbounded;    use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;
with Ada.Containers.Vectors;

procedure Meu_Projeto_Ada is
   -- 1. Configuração do Vector para Palavras Reservadas (Dinamismo)
   package String_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => Unbounded_String);
   use String_Vectors;

   Palavras_Reservadas : Vector;
   Input_Raw           : String (1 .. 100);
   Tam                 : Natural;

   -- Procedimento para alimentar a nossa "Lista Negra" de palavras
   procedure Carregar_Dicionario is
      procedure Add (S : String) is
      begin
         Palavras_Reservadas.Append (To_Unbounded_String (S));
      end Add;
   begin
      Add ("if");
      Add ("then");
      Add ("else");
      Add ("elsif");
      Add ("begin");
      Add ("procedure");
      Add ("is");
      Add ("end");
      Add ("loop");
      Add ("with");
      Add ("use");
      Add ("put");
      Add ("put_line");
      Add ("get");
      Add ("return");
      Add ("type");
   end Carregar_Dicionario;

   -- Lógica para classificar números (Inteiros/Reais e Positivos/Negativos)
   procedure Classificar_Token_Numerico
     (S : String; Eh_Num : out Boolean; Msg : out Unbounded_String)
   is
      Tem_Ponto : Boolean  := False;
      Inicio    : Positive := S'First;
      Eh_Neg    : Boolean  := False;
   begin
      Eh_Num := False;
      if S'Length = 0 then
         return;
      end if;

      -- Verifica sinal negativo
      if S (S'First) = '-' then
         if S'Length = 1 then
            return;
         end if;
         Eh_Neg := True;
         Inicio := S'First + 1;
      end if;

      for I in Inicio .. S'Last loop
         if S (I) = '.' then
            if Tem_Ponto then
               return;
            end if; -- Segundo ponto é erro
            Tem_Ponto := True;
         elsif not Is_Digit (S (I)) then
            return; -- Se houver letra, não é um número puro
         end if;
      end loop;

      Eh_Num := True;
      if Tem_Ponto then
         Msg :=
           To_Unbounded_String
             (if Eh_Neg then "Numero Real Negativo (Float)"
              else "Numero Real (Float)");
      else
         Msg :=
           To_Unbounded_String
             (if Eh_Neg then "Numero Inteiro Negativo (Integer)"
              else "Numero Inteiro (Integer)");
      end if;
   end Classificar_Token_Numerico;

begin
   Carregar_Dicionario;

   Put_Line ("===========================================");
   Put_Line ("     ANALISADOR DE TOKENS (VERSAO 2.0)     ");
   Put_Line ("===========================================");
   New_Line;

   Put ("Insira um lexema (comando, numero ou variavel): ");
   Get_Line (Input_Raw, Tam);

   declare
      S            : constant String := Input_Raw (1 .. Tam);
      S_Lower      : constant String := To_Lower (S);
      Eh_Reservada : Boolean         := False;
      Eh_Numerico  : Boolean         := False;
      Msg_Num      : Unbounded_String;
   begin
      -- PASSO 1: Verificar se é Palavra Reservada
      for Cursor in Palavras_Reservadas.Iterate loop
         if S_Lower = To_Lower (To_String (Element (Cursor))) then
            Eh_Reservada := True;
            exit;
         end if;
      end loop;

      if Eh_Reservada then
         Put_Line ("Resultado: [PALAVRA RESERVADA / COMANDO]");

         -- PASSO 2: Verificar se é Número (Inteiro ou Real)
      else
         Classificar_Token_Numerico (S, Eh_Numerico, Msg_Num);
         if Eh_Numerico then
            Put ("Resultado: [");
            Put (Msg_Num);
            Put_Line ("]");

            -- PASSO 3: Verificar se é Identificador (As 4 Regras)
         else
            -- Regra 1: Começar com Letra | Regra 3: Não terminar com _
            if Tam > 0 and then Is_Letter (S (1)) and then S (Tam) /= '_'
               -- Regra 2: Apenas Alfanuméricos ou _

              and then
              (for all I in S'Range => Is_Alphanumeric (S (I)) or S (I) = '_')
               -- Regra 4: Não ter "__"

              and then
              (for all I in S'First .. S'Last - 1 =>
                 not (S (I) = '_' and S (I + 1) = '_'))
            then
               Put_Line ("Resultado: [IDENTIFICADOR VALIDO]");
            else
               Put_Line ("Resultado: [LEXEMA INVALIDO / NAO RECONHECIDO]");
            end if;
         end if;
      end if;
   end;

   New_Line;
   Put_Line ("Processamento concluido.");
end Meu_Projeto_Ada;
