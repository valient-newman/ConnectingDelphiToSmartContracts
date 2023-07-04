{******************************************************************************}
{                                                                              }
{                                  Delphereum                                  }
{                                                                              }
{             Copyright(c) 2018 Stefan van As <svanas@runbox.com>              }
{           Github Repository <https://github.com/svanas/delphereum>           }
{                                                                              }
{             Distributed under GNU AGPL v3.0 with Commons Clause              }
{                                                                              }
{   This program is free software: you can redistribute it and/or modify       }
{   it under the terms of the GNU Affero General Public License as published   }
{   by the Free Software Foundation, either version 3 of the License, or       }
{   (at your option) any later version.                                        }
{                                                                              }
{   This program is distributed in the hope that it will be useful,            }
{   but WITHOUT ANY WARRANTY; without even the implied warranty of             }
{   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              }
{   GNU Affero General Public License for more details.                        }
{                                                                              }
{   You should have received a copy of the GNU Affero General Public License   }
{   along with this program.  If not, see <https://www.gnu.org/licenses/>      }
{                                                                              }
{******************************************************************************}
// Delphereum Study. Tutorial 'Connecting Delphi to Smart Contracts'
// Project in Embarcadero Delphi 11 made with source of this tutorial: https://svanas.medium.com/connecting-delphi-to-smart-contracts-3146b12803a1
// Prepared by Valient Newman <valient.newman@proton.me>
// My Github Repository <https://github.com/valient-newman>
unit ConnectingDelphiToSmartContractsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses
  web3, web3.eth, web3.eth.utils, web3.eth.types, Velthuis.BigIntegers;


procedure TForm1.Button1Click(Sender: TObject);
begin
const Client: IWeb3 = TWeb3.Create('https://mainnet.infura.io/v3/your-project-id');
web3.eth.call(Client, '0xB8c77482e45F1F44dE1745F52C74426C631bDD52', 'symbol()', [], procedure(tup: TTuple; err: IError)
begin
  if Assigned(err) then
  begin
    TThread.Synchronize(nil, procedure
    begin
      MessageDlg(err.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0)
    end);
    EXIT;
  end;
  const Symbol = tup.ToString;
  web3.eth.call(Client, '0xB8c77482e45F1F44dE1745F52C74426C631bDD52', 'totalSupply()', [], procedure(str: string; err: IError)
  begin
    TThread.Synchronize(nil, procedure
    begin
      if Assigned(err) then
        MessageDlg(err.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0)
      else
        ShowMessage(web3.eth.utils.fromWei(str, web3.eth.utils.ether) + ' ' + Symbol);
    end);
  end);
end);
end;

end.
