with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Characters.Handling;    use Ada.Characters.Handling;
with Ada.Strings.Unbounded;      use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;

procedure exercicio2_identificadores is
   -- 1. Definindo o Vector de Strings (ArrayList)
   package String_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Unbounded_String);
   use String_Vectors;

   Palavras_Reservadas : Vector;
   Lexema_Input        : String (1 .. 100);
   Tam                 : Natural;
   Valido              : Boolean := True;

   -- Procedimento para carregar a lista sem se preocupar com espaços
   procedure Carregar_Dicionario is
   begin
      Palavras_Reservadas.Append (To_Unbounded_String ("if"));
      Palavras_Reservadas.Append (To_Unbounded_String ("then"));
      Palavras_Reservadas.Append (To_Unbounded_String ("else"));
      Palavras_Reservadas.Append (To_Unbounded_String ("elsif"));
      Palavras_Reservadas.Append (To_Unbounded_String ("end"));
      Palavras_Reservadas.Append (To_Unbounded_String ("procedure"));
      Palavras_Reservadas.Append (To_Unbounded_String ("is"));
      Palavras_Reservadas.Append (To_Unbounded_String ("begin"));
      Palavras_Reservadas.Append (To_Unbounded_String ("loop"));
      Palavras_Reservadas.Append (To_Unbounded_String ("with"));
      Palavras_Reservadas.Append (To_Unbounded_String ("use"));
      Palavras_Reservadas.Append (To_Unbounded_String ("put"));
      Palavras_Reservadas.Append (To_Unbounded_String ("put_line"));
      Palavras_Reservadas.Append (To_Unbounded_String ("get"));
      Palavras_Reservadas.Append (To_Unbounded_String ("return"));
      Palavras_Reservadas.Append (To_Unbounded_String ("type"));
      Palavras_Reservadas.Append (To_Unbounded_String ("array"));
      Palavras_Reservadas.Append (To_Unbounded_String ("constant"));
   end Carregar_Dicionario;

begin
   Carregar_Dicionario;

   Put_Line ("=== ANALISADOR LEXICO PRO (VECTORS & UNBOUNDED) ===");
   Put ("Digite o lexema: ");
   Get_Line (Lexema_Input, Tam);

   declare
      S_Digitada : constant String := To_Lower (Lexema_Input (1 .. Tam));
   begin
      -- 1. VERIFICAÇÃO NO VECTOR (Busca Dinâmica)
      for Cursor in Palavras_Reservadas.Iterate loop
         if S_Digitada = To_Lower (To_String (Element (Cursor))) then
            Valido := False;
            Put_Line ("ERRO: '" & S_Digitada & "' e uma PALAVRA RESERVADA.");
            exit;
         end if;
      end loop;

      -- 2. REGRAS MORFOLÓGICAS (Só executa se não for reservada)
      if Valido then
         if Tam = 0 or else not Is_Letter (Lexema_Input (1)) then
            Valido := False;
            Put_Line ("ERRO: Deve comecar com uma letra.");
         elsif Lexema_Input (Tam) = '_' then
            Valido := False;
            Put_Line ("ERRO: Nao pode terminar com underscore (_).");
         else
            for I in 1 .. Tam loop
               if not (Is_Alphanumeric (Lexema_Input (I)) or (Lexema_Input (I) = '_')) then
                  Valido := False;
                  Put_Line ("ERRO: Caractere invalido: " & Lexema_Input (I));
                  exit;
               elsif I < Tam and then (Lexema_Input (I) = '_' and Lexema_Input (I + 1) = '_') then
                  Valido := False;
                  Put_Line ("ERRO: Sequencia '__' invalida.");
                  exit;
               end if;
            end loop;
         end if;
      end if;
   end;

   New_Line;
   if Valido then
      Put_Line ("Resultado: IDENTIFICADOR VALIDO.");
   else
      Put_Line ("Resultado: Lexema REJEITADO.");
   end if;

end exercicio2_identificadores;