{******************************************************************************}
{* This file is part of SAS.Planet project.                                   *}
{*                                                                            *}
{* Copyright (C) 2007-2021, SAS.Planet development team.                      *}
{*                                                                            *}
{* SAS.Planet is free software: you can redistribute it and/or modify         *}
{* it under the terms of the GNU General Public License as published by       *}
{* the Free Software Foundation, either version 3 of the License, or          *}
{* (at your option) any later version.                                        *}
{*                                                                            *}
{* SAS.Planet is distributed in the hope that it will be useful,              *}
{* but WITHOUT ANY WARRANTY; without even the implied warranty of             *}
{* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the               *}
{* GNU General Public License for more details.                               *}
{*                                                                            *}
{* You should have received a copy of the GNU General Public License          *}
{* along with SAS.Planet. If not, see <http://www.gnu.org/licenses/>.         *}
{*                                                                            *}
{* https://github.com/sasgis/sas.planet.src                                   *}
{******************************************************************************}

unit u_ThreadCacheManagerAbstract;

interface

uses
  Classes,
  {$IFNDEF UNICODE}
  Compatibility,
  {$ENDIF}
  i_Listener,
  i_NotifierOperation;

type
  TThreadCacheManagerAbstract = class(TThread)
  private
    FOperationID: Integer;
    FCancelListener: IListener;
    FMessageForShow: string;
    FCancelNotifier: INotifierOperation;
    FDebugThreadName: string;
    procedure OnCancel;
    procedure SynShowMessage;
    {$HINTS OFF}
    // Disable hint: "Private symbol 'ShowMessageSync' declared but never used"
    // in case we catch exceptions by EurekaLog (see below)
    procedure ShowMessageSync(const AMessage: string);
    {$HINTS ON}
  protected
    procedure Process; virtual; abstract;
    procedure Execute; override;
    property CancelNotifier: INotifierOperation read FCancelNotifier;
  public
    constructor Create(
      const ACancelNotifier: INotifierOperation;
      const AOperationID: Integer;
      const ADebugThreadName: string = ''
    );
    destructor Destroy; override;
  end;

implementation

uses
  {$IFDEF EUREKALOG}
  ExceptionLog,
  {$ENDIF}
  Dialogs,
  SysUtils,
  u_ReadableThreadNames,
  u_ListenerByEvent;

{ TThreadCacheManagerAbstract }

constructor TThreadCacheManagerAbstract.Create(
  const ACancelNotifier: INotifierOperation;
  const AOperationID: Integer;
  const ADebugThreadName: string = ''
);
begin
  inherited Create(True);
  FDebugThreadName := ADebugThreadName;
  Self.Priority := tpNormal;
  Self.FreeOnTerminate := True;
  FCancelNotifier := ACancelNotifier;
  FOperationID := AOperationID;
  if not FCancelNotifier.IsOperationCanceled(FOperationID) then begin
    FCancelListener := TNotifyNoMmgEventListener.Create(Self.OnCancel);
    FCancelNotifier.AddListener(FCancelListener);
  end;
end;

destructor TThreadCacheManagerAbstract.Destroy;
begin
  if Assigned(FCancelNotifier) and Assigned(FCancelListener) then begin
    FCancelNotifier.RemoveListener(FCancelListener);
    FCancelListener := nil;
    FCancelNotifier := nil;
  end;
  inherited;
end;

procedure TThreadCacheManagerAbstract.Execute;
begin
  SetCurrentThreadName(FDebugThreadName);
  try
    Process;
  except
  {$IFDEF EUREKALOG}
    ShowLastExceptionData;
  {$ELSE}
    on E: Exception do begin
      ShowMessageSync(E.ClassName + ': ' + E.Message);
    end;
  {$ENDIF}
  end;
end;

procedure TThreadCacheManagerAbstract.OnCancel;
begin
  Terminate;
end;

procedure TThreadCacheManagerAbstract.ShowMessageSync(const AMessage: string);
begin
  FMessageForShow := AMessage;
  Synchronize(SynShowMessage);
end;

procedure TThreadCacheManagerAbstract.SynShowMessage;
begin
  ShowMessage(FMessageForShow);
end;

end.


