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

unit u_MarkCategoryFactoryDbInternalORM;

interface

uses
  t_MarkSystemORM,
  i_MarkCategory,
  i_MarkCategoryFactoryDbInternalORM,
  u_BaseInterfacedObject;

type
  TMarkCategoryFactoryDbInternalORM = class(TBaseInterfacedObject, IMarkCategoryFactoryDbInternalORM)
  private
    FDbId: Integer;
  private
    function CreateCategory(
      const AId: TID;
      const AName: string;
      const AVisible: Boolean;
      const AAfterScale: Byte;
      const ABeforeScale: Byte
    ): IMarkCategory; overload;

    function CreateCategory(
      const ACategoryRec: TSQLCategoryRec
    ): IMarkCategory; overload;
  public
    constructor Create(const ADbId: Integer);
  end;

implementation

uses
  u_MarkCategoryDbInternalORM;

{ TMarkCategoryFactoryDbInternalORM }

constructor TMarkCategoryFactoryDbInternalORM.Create(const ADbId: Integer);
begin
  inherited Create;
  FDbId := ADbId;
end;

function TMarkCategoryFactoryDbInternalORM.CreateCategory(
  const AId: TID;
  const AName: string;
  const AVisible: Boolean;
  const AAfterScale: Byte;
  const ABeforeScale: Byte
): IMarkCategory;
begin
  Result :=
    TMarkCategoryDbInternalORM.Create(
      AId,
      FDbId,
      AName,
      AVisible,
      AAfterScale,
      ABeforeScale
    );
end;

function TMarkCategoryFactoryDbInternalORM.CreateCategory(
  const ACategoryRec: TSQLCategoryRec
): IMarkCategory;
begin
  Result :=
    TMarkCategoryDbInternalORM.Create(
      ACategoryRec.FCategoryId,
      FDbId,
      ACategoryRec.FName,
      ACategoryRec.FVisible,
      ACategoryRec.FMinZoom,
      ACategoryRec.FMaxZoom
    )
end;

end.
