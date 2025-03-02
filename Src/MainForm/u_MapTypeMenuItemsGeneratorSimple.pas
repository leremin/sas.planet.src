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

unit u_MapTypeMenuItemsGeneratorSimple;

interface

uses
  Classes,
  TB2Item,
  TBX,
  i_MapTypeSet,
  i_MapType,
  i_MapTypeGUIConfigList;

type
  TMapMenuGeneratorSimple = class
  private
    FGUIConfigList: IMapTypeGUIConfigList;
    FMapsSet: IMapTypeSet;
    FRootMenu: TTBCustomItem;
    FOnClick: TNotifyEvent;
    procedure ProcessSubItemsCreate;
    procedure ProcessSubItemGUID(const AGUID: TGUID);
    function CreateSubMenuItem(const AName: string): TTBCustomItem;
    function GetParentMenuItem(const AName: string): TTBCustomItem;
    function CreateMenuItem(const AMapType: IMapType): TTBXCustomItem;
  public
    constructor Create(
      const AGUIConfigList: IMapTypeGUIConfigList;
      const AMapsSet: IMapTypeSet;
      ARootMenu: TTBCustomItem;
      AOnClick: TNotifyEvent
    );
    procedure BuildControls;
  end;

implementation

uses
  SysUtils,
  {$IF CompilerVersion <= 18.5}
  Compatibility,
  {$IFEND}
  i_GUIDListStatic,
  u_TBXSubmenuItemWithIndicator;

{ TMapMenuGeneratorSimple }

constructor TMapMenuGeneratorSimple.Create(
  const AGUIConfigList: IMapTypeGUIConfigList;
  const AMapsSet: IMapTypeSet;
  ARootMenu: TTBCustomItem;
  AOnClick: TNotifyEvent
);
begin
  Assert(AGUIConfigList <> nil);
  Assert(AMapsSet <> nil);
  inherited Create;
  FGUIConfigList := AGUIConfigList;
  FMapsSet := AMapsSet;
  FRootMenu := ARootMenu;
  FOnClick := AOnClick;
end;

function TMapMenuGeneratorSimple.CreateMenuItem(
  const AMapType: IMapType
): TTBXCustomItem;
begin
  Result := TTBXItem.Create(FRootMenu);
  Result.Tag := NativeInt(AMapType);
  Result.Caption := AMapType.GUIConfig.Name.Value;
  Result.OnClick := FOnClick;
end;

function TMapMenuGeneratorSimple.CreateSubMenuItem(
  const AName: string
): TTBCustomItem;
begin
  Result := TTBXSubmenuItemWithIndicator.Create(FRootMenu);
  Result.Caption := AName;
  Result.tag := -1;
end;

function TMapMenuGeneratorSimple.GetParentMenuItem(
  const AName: string
): TTBCustomItem;
const
  CLineBreak = '\';
var
  i, j: Integer;
  VName: string;
  VParent, Vmenu: TTBCustomItem;
  VNameParts: TStringList;
begin
  if (AName = '') then begin
    Result := FRootMenu;
  end else begin
    if Pos(CLineBreak, AName) <> 0 then begin
      VNameParts := TStringList.Create;
      try
        VNameParts.LineBreak := CLineBreak;
        VNameParts.Text := AName;
        Vmenu := FRootMenu;
        for j := 0 to VNameParts.Count - 1 do begin
          VParent := Vmenu;
          VName := VNameParts.Strings[j];
          if Vname = '' then begin
            Vmenu := VParent; // Fix for multiple LineBreak
          end else begin
            Vmenu := nil;
            for i := 0 to VParent.Count - 1 do begin
              if SameText(VParent.Items[i].Caption, VName) then begin
                Vmenu := VParent.Items[i];
                Break;
              end;
            end;
          end;
          if Vmenu = nil then begin
            Vmenu := CreateSubMenuItem(VName);
            VParent.Add(Vmenu);
          end;
        end;
        Result := Vmenu;
      finally
        FreeAndNil(VNameParts);
      end;
    end else begin
      VName := AName;
      Result := nil;
      for i := 0 to FRootMenu.Count - 1 do begin
        if SameText(FRootMenu.Items[i].Caption, VName) then begin
          Result := FRootMenu.Items[i];
          Break;
        end;
      end;
      if Result = nil then begin
        Result := CreateSubMenuItem(VName);
        FRootMenu.Add(Result);
      end;
    end;
  end;
end;

procedure TMapMenuGeneratorSimple.BuildControls;
begin
  ProcessSubItemsCreate;
end;

procedure TMapMenuGeneratorSimple.ProcessSubItemGUID(const AGUID: TGUID);
var
  VMapType: IMapType;
  VSubMenu: TTBCustomItem;
  VMenuItem: TTBXCustomItem;
  VSubMenuName: string;
  VEnabled: Boolean;
begin
  VMapType := FMapsSet.GetMapTypeByGUID(AGUID);
  if VMapType <> nil then begin
    VEnabled := VMapType.GUIConfig.Enabled;
    VSubMenuName := VMapType.GUIConfig.ParentSubMenu.Value;
    if VEnabled then begin
      VSubMenu := GetParentMenuItem(VSubMenuName);
      Assert(Assigned(VSubMenu));
      VMenuItem := CreateMenuItem(VMapType);
      Assert(Assigned(VMenuItem));
      VSubMenu.Add(VMenuItem);
      if VMapType.GUIConfig.Separator then begin
        VSubMenu.Add(TTBSeparatorItem.Create(FRootMenu));
      end;
    end;
  end;
end;

procedure TMapMenuGeneratorSimple.ProcessSubItemsCreate;
var
  i: Integer;
  VStaticList: IGUIDListStatic;
begin
  VStaticList := FGUIConfigList.OrderedMapGUIDList;
  for i := 0 to VStaticList.Count - 1 do begin
    ProcessSubItemGUID(VStaticList.Items[i]);
  end;
end;

end.
