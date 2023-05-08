unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, php4delphi, PHPCommon, PHPTypes
  ,zend_dynamic_array
  ,zendAPI
  ,zendTypes
  ,phpAPI
  ,phpApp
  ,phpClass
  ,PHPCustomLibrary
  ,phpFunctions
  ,phpLibrary
  ,phpModules
  ,DelphiFunctions
  ,logos
  //,php4AppIntf
  ,php4AppUnit
  ,phpAbout
  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Panel1: TPanel;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure PHPLibrary1Functions0Execute(Sender: TObject;
      Parameters: TFunctionParams; var ReturnValue: Variant;
      ZendVar: TZendVariable; TSRMLS_DC: Pointer);
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1;
  psvPHP:TpsvPHP;
  PHPEngine: TPHPEngine;
  PHPLibrary1: TPHPLibrary;

implementation

//{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
    psvPHP:= TpsvPHP.Create(self);
//    psvPHP.Variables;
    psvPHP.Variables.Add;
    psvPHP.Variables.Items[0].Name:='test';
    psvPHP.Variables.Items[0].Value:='This works!' ;

    psvPHP.Variables.Add;
    psvPHP.Variables.Items[1].Name:='tool';
    psvPHP.Variables.Items[1].Value:='Delphi' ;
    psvPHP.RequestType:=prtPost;
    //psvPHP.OnReadPost = psvPHPReadPost

    PHPLibrary1:= TPHPLibrary.Create(self);
    PHPLibrary1.LibraryName:='Test';
    PHPLibrary1.Functions.Add;
    PHPLibrary1.Functions.Items[0].FunctionName:='test01';
    PHPLibrary1.Functions.Items[0].Parameters.Add;
    PHPLibrary1.Functions.Items[0].Parameters.Items[0].Name:='param1';
    PHPLibrary1.Functions.Items[0].Parameters.Items[0].ParamType:=tpString;
    PHPLibrary1.Functions.Items[0].OnExecute:=@PHPLibrary1Functions0Execute;


    PHPLibrary1.Functions.Add;
    PHPLibrary1.Functions.Items[1].FunctionName:='test02';
    PHPLibrary1.Functions.Items[1].Parameters.Add;
    PHPLibrary1.Functions.Items[1].Parameters.Items[0].Name:='param1';
    PHPLibrary1.Functions.Items[1].Parameters.Items[0].ParamType:=tpString;
    PHPLibrary1.Functions.Items[1].Parameters.Add;
    PHPLibrary1.Functions.Items[1].Parameters.Items[1].Name:='param2';
    PHPLibrary1.Functions.Items[1].Parameters.Items[1].ParamType:=tpInteger;
    //    PHPLibrary1.Functions.Items[0].OnExecute:=;

    PHPEngine:= TPHPEngine.Create(self);
//    PHPEngine.OnLogMessage = psvPHPLogMessage
//      PHPEngine.Constants := <> ;
      PHPEngine.ReportDLLError := False;
      //PHPEngine.StartupEngine;


end;

procedure TForm1.PHPLibrary1Functions0Execute(Sender: TObject;
  Parameters: TFunctionParams; var ReturnValue: Variant;
  ZendVar: TZendVariable; TSRMLS_DC: Pointer);
begin
        ShowMessage(Parameters.Items[0].Value);
end;

procedure TForm1.Button1Click(Sender: TObject);
var doc:String;
begin
      doc := '';
      doc := psvPHP.RunCode(Memo1.Text);
      Memo2.Text:=doc;
end;

end.

