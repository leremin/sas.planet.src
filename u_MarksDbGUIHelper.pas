{******************************************************************************}
{* SAS.Planet (SAS.�������)                                                   *}
{* Copyright (C) 2007-2011, SAS.Planet development team.                      *}
{* This program is free software: you can redistribute it and/or modify       *}
{* it under the terms of the GNU General Public License as published by       *}
{* the Free Software Foundation, either version 3 of the License, or          *}
{* (at your option) any later version.                                        *}
{*                                                                            *}
{* This program is distributed in the hope that it will be useful,            *}
{* but WITHOUT ANY WARRANTY; without even the implied warranty of             *}
{* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              *}
{* GNU General Public License for more details.                               *}
{*                                                                            *}
{* You should have received a copy of the GNU General Public License          *}
{* along with this program.  If not, see <http://www.gnu.org/licenses/>.      *}
{*                                                                            *}
{* http://sasgis.ru                                                           *}
{* az@sasgis.ru                                                               *}
{******************************************************************************}

unit u_MarksDbGUIHelper;

interface

uses
  Windows,
  Classes,
  ComCtrls,
  t_GeoTypes,
  i_CoordConverter,
  i_ValueToStringConverter,
  i_MarkPicture,
  i_MarksSimple,
  i_MarkCategory,
  frm_MarkEditPoint,
  frm_MarkEditPath,
  frm_MarkEditPoly,
  frm_RegionProcess,
  u_MarksSystem;

type
  TMarksDbGUIHelper = class
  private
    FMarksDB: TMarksSystem;
    FMarkPictureList: IMarkPictureList;
    FValueToStringConverterConfig: IValueToStringConverterConfig;
    FFormRegionProcess: TfrmRegionProcess;
    FfrmMarkEditPoint: TfrmMarkEditPoint;
    FfrmMarkEditPath: TfrmMarkEditPath;
    FfrmMarkEditPoly: TfrmMarkEditPoly;
  public
    procedure CategoryListToStrings(AList: IInterfaceList; AStrings: TStrings);
    procedure CategoryListToTree(AList: IInterfaceList; ATreeItems: TTreeNodes);
    procedure MarksListToStrings(AList: IInterfaceList; AStrings: TStrings);

    function DeleteMarkModal(AMarkID: IMarkID; handle:THandle):boolean;
    function OperationMark(AMark: IMark; AZoom: Byte; AConverter: ICoordConverter):boolean;
    function AddKategory(name:string): IMarkCategory;
    procedure ShowMarkLength(AMark: IMarkLine; AConverter: ICoordConverter; AHandle: THandle); overload;
    procedure ShowMarkLength(AMark: IMarkPoly; AConverter: ICoordConverter; AHandle: THandle); overload;
    procedure ShowMarkSq(AMark: IMarkPoly; AConverter: ICoordConverter; AHandle: THandle);
    function EditMarkModal(AMark: IMark): IMark;
    function AddNewPointModal(ALonLat: TDoublePoint): Boolean;
    function SavePolyModal(AMark: IMarkPoly; ANewArrLL: TArrayOfDoublePoint): Boolean;
    function SaveLineModal(AMark: IMarkLine; ANewArrLL: TArrayOfDoublePoint; ADescription: string): Boolean;

    property MarksDB: TMarksSystem read FMarksDB;
    property MarkPictureList: IMarkPictureList read FMarkPictureList;
  public
    constructor Create(
      AMarksDB: TMarksSystem;
      AValueToStringConverterConfig: IValueToStringConverterConfig;
      AMarkPictureList: IMarkPictureList;
      AFormRegionProcess: TfrmRegionProcess
    );
    destructor Destroy; override;
  end;

implementation

uses
  SysUtils,
  Dialogs,
  i_Datum,
  i_StaticTreeItem,
  u_ResStrings,
  u_GeoFun,
  u_GeoToStr;

{ TMarksDbGUIHelper }

constructor TMarksDbGUIHelper.Create(
  AMarksDB: TMarksSystem;
  AValueToStringConverterConfig: IValueToStringConverterConfig;
  AMarkPictureList: IMarkPictureList;
  AFormRegionProcess: TfrmRegionProcess
);
begin
  FMarkPictureList := AMarkPictureList;
  FMarksDB := AMarksDB;
  FValueToStringConverterConfig := AValueToStringConverterConfig;
  FFormRegionProcess := AFormRegionProcess;
  FfrmMarkEditPoint := TfrmMarkEditPoint.Create(nil, FMarksDB.CategoryDB, FMarksDB.MarksDb);
  FfrmMarkEditPath := TfrmMarkEditPath.Create(nil, FMarksDB.CategoryDB, FMarksDB.MarksDb);
  FfrmMarkEditPoly := TfrmMarkEditPoly.Create(nil, FMarksDB.CategoryDB, FMarksDB.MarksDb);
end;

destructor TMarksDbGUIHelper.Destroy;
begin
  FreeAndNil(FfrmMarkEditPoint);
  FreeAndNil(FfrmMarkEditPath);
  FreeAndNil(FfrmMarkEditPoly);
  inherited;
end;

function TMarksDbGUIHelper.AddKategory(name: string): IMarkCategory;
var
  VCategory: IMarkCategory;
begin
  VCategory := FMarksDB.CategoryDB.Factory.CreateNew(name);
  Result := FMarksDb.CategoryDB.GetCategoryByName(VCategory.Name);
  if Result = nil then begin
    Result := FMarksDb.CategoryDB.WriteCategory(VCategory);
  end;
end;

function TMarksDbGUIHelper.AddNewPointModal(ALonLat: TDoublePoint): Boolean;
var
  VMark: IMarkPoint;
begin
  Result := False;
  VMark := FMarksDB.MarksDb.Factory.CreateNewPoint(ALonLat, '', '');
  VMark := FfrmMarkEditPoint.EditMark(VMark);
  if VMark <> nil then begin
    FMarksDb.MarksDb.WriteMark(VMark);
    Result := True;
  end;
end;

procedure TMarksDbGUIHelper.MarksListToStrings(AList: IInterfaceList;
  AStrings: TStrings);
var
  i: Integer;
  VMarkId: IMarkId;
begin
  AStrings.Clear;
  for i := 0 to AList.Count - 1 do begin
    VMarkId := IMarkId(AList[i]);
    AStrings.AddObject(VMarkId.name, Pointer(VMarkId));
  end;
end;

procedure TMarksDbGUIHelper.CategoryListToStrings(AList: IInterfaceList; AStrings: TStrings);
var
  i: Integer;
  VCategory: IMarkCategory;
begin
  AStrings.Clear;
  for i := 0 to AList.Count - 1 do begin
    VCategory := IMarkCategory(AList[i]);
    AStrings.AddObject(VCategory.name, Pointer(VCategory));
  end;
end;

procedure TMarksDbGUIHelper.CategoryListToTree(AList: IInterfaceList; ATreeItems: TTreeNodes);
  procedure AddTreeSubItems(ATree: IStaticTreeItem; AParentNode: TTreeNode);
  var
    i: Integer;
    VTree: IStaticTreeItem;
    VNode: TTreeNode;
    VCategory: IMarkCategory;
    VName: string;
  begin
    for i := 0 to ATree.SubItemCount - 1 do begin
      VTree := ATree.SubItem[i];
      VName := VTree.Name;
      if VName = '' then begin
        VName := '(NoName)';
      end;
      VNode := ATreeItems.AddChildObject(AParentNode, VName, nil);
      VNode.StateIndex:=0;
      if Supports(VTree.Data, IMarkCategory, VCategory) then begin
        VNode.Data := Pointer(VCategory);
        if VCategory.Visible then begin
          VNode.StateIndex := 1;
        end else begin
          VNode.StateIndex := 2;
        end;
      end;
      AddTreeSubItems(VTree, VNode);
    end;
  end;
var
  VTree: IStaticTreeItem;
begin
  VTree := MarksDB.CategoryListToStaticTree(AList);
  ATreeItems.BeginUpdate;
  try
    ATreeItems.Clear;
    AddTreeSubItems(VTree, nil);
  finally
    ATreeItems.EndUpdate;
  end;
end;

function TMarksDbGUIHelper.DeleteMarkModal(AMarkID: IMarkID;
  handle: THandle): boolean;
begin
  Result := false;
  if AMarkID <> nil then begin
    if MessageBox(handle,pchar(SAS_MSG_youasure+' "'+AMarkID.name+'"'),pchar(SAS_MSG_coution),36)=IDYES then begin
      result := FMarksDb.MarksDb.DeleteMark(AMarkID);
    end;
  end;
end;

function TMarksDbGUIHelper.EditMarkModal(AMark: IMark): IMark;
var
  VMarkPoint: IMarkPoint;
  VMarkLine: IMarkLine;
  VMarkPoly: IMarkPoly;
begin
  Result := nil;
  if Supports(AMark, IMarkPoint, VMarkPoint) then begin
    Result := FfrmMarkEditPoint.EditMark(VMarkPoint);
  end else if Supports(AMark, IMarkLine, VMarkLine) then begin
    Result := FfrmMarkEditPath.EditMark(VMarkLine);
  end else if Supports(AMark, IMarkPoly, VMarkPoly) then begin
    Result := FfrmMarkEditPoly.EditMark(VMarkPoly);
  end;
end;

procedure TMarksDbGUIHelper.ShowMarkLength(AMark: IMarkLine; AConverter: ICoordConverter; AHandle: THandle);
var
  i:integer;
  VPointCount: Integer;
  VLen: Double;
  VMessage: string;
  VDatum: IDatum;
begin
  if AMark <> nil then begin
    VPointCount := Length(AMark.Points);
    if (VPointCount > 1) then begin
      VLen:=0;
      VDatum := AConverter.Datum;
      for i:=0 to VPointCount-2 do begin
        VLen:=VLen+ VDatum.CalcDist(AMark.Points[i], AMark.Points[i+1]);
      end;
      VMessage := SAS_STR_L+' - '+
        FValueToStringConverterConfig.GetStatic.DistConvert(VLen);
      MessageBox(AHandle, pchar(VMessage), pchar(AMark.name),0);
    end;
  end;
end;

procedure TMarksDbGUIHelper.ShowMarkLength(AMark: IMarkPoly; AConverter: ICoordConverter; AHandle: THandle);
var
  i:integer;
  VPointCount: Integer;
  VLen: Double;
  VMessage: string;
  VDatum: IDatum;
begin
  if AMark <> nil then begin
    VPointCount := Length(AMark.Points);
    if (VPointCount > 1) then begin
      VLen:=0;
      VDatum := AConverter.Datum;
      for i:=0 to VPointCount-2 do begin
        VLen:=VLen+ VDatum.CalcDist(AMark.Points[i], AMark.Points[i+1]);
      end;
      VMessage := SAS_STR_P+' - '+
        FValueToStringConverterConfig.GetStatic.DistConvert(VLen);
      MessageBox(AHandle, pchar(VMessage), pchar(AMark.name),0);
    end;
  end;
end;

procedure TMarksDbGUIHelper.ShowMarkSq(AMark: IMarkPoly; AConverter: ICoordConverter; AHandle: THandle);
var
  VArea: Double;
  VMessage: string;
begin
  if AMark <> nil then begin
    if (Length(AMark.Points) > 1) then begin
      VArea:= AConverter.Datum.CalcPoligonArea(AMark.Points);
      VMessage := SAS_STR_S+' - '+FValueToStringConverterConfig.GetStatic.AreaConvert(VArea);
      MessageBox(AHandle,pchar(VMessage),pchar(AMark.name),0);
    end;
  end;
end;

function TMarksDbGUIHelper.OperationMark(AMark: IMark; AZoom: Byte; AConverter: ICoordConverter): boolean;
var
  VMarkPoly: IMarkPoly;
  VMarkLine: IMarkLine;
  VPoints: TArrayOfDoublePoint;
  VRadius: double;
  VDefRadius: String;
begin
  Result:=false;
  if Supports(AMark, IMarkPoly, VMarkPoly) then begin
    FFormRegionProcess.Show_(AZoom, VMarkPoly.Points);
    Result:=true;
  end else begin
    if Supports(AMark, IMarkLine, VMarkLine) then begin
      VDefRadius:='100';
      if InputQuery('','Radius , m', VDefRadius) then begin
        try
          VRadius:=str2r(VDefRadius);
        except
          ShowMessage(SAS_ERR_ParamsInput);
          Exit;
        end;
        VPoints:=ConveryPolyline2Polygon(VMarkLine.Points, VRadius, AConverter, AZoom);
        FFormRegionProcess.Show_(AZoom, VPoints);
        Result:=true;
      end;
    end else begin
      ShowMessage(SAS_MSG_FunExForPoly);
    end;
  end;
end;

function TMarksDbGUIHelper.SaveLineModal(AMark: IMarkLine;
  ANewArrLL: TArrayOfDoublePoint; ADescription: string): Boolean;
var
  VMark: IMarkLine;
begin
  Result := False;
  if AMark <> nil then begin
    VMark := FMarksDB.MarksDb.Factory.SimpleModifyLine(AMark, ANewArrLL, ADescription);
  end else begin
    VMark := FMarksDB.MarksDb.Factory.CreateNewLine(ANewArrLL, '', ADescription);
  end;
  if VMark <> nil then begin
    VMark := FfrmMarkEditPath.EditMark(VMark);
    if VMark <> nil then begin
      FMarksDb.MarksDb.WriteMark(VMark);
      Result := True;
    end;
  end;
end;

function TMarksDbGUIHelper.SavePolyModal(
  AMark: IMarkPoly;
  ANewArrLL: TArrayOfDoublePoint
): Boolean;
var
  VMark: IMarkPoly;
begin
  Result := False;
  if AMark <> nil then begin
    VMark := FMarksDB.MarksDb.Factory.SimpleModifyPoly(AMark, ANewArrLL);
  end else begin
    VMark := FMarksDB.MarksDb.Factory.CreateNewPoly(ANewArrLL, '', '');
  end;
  if VMark <> nil then begin
    VMark := FfrmMarkEditPoly.EditMark(VMark);
    if VMark <> nil then begin
      FMarksDb.MarksDb.WriteMark(VMark);
      Result := True;
    end;
  end;
end;

end.
