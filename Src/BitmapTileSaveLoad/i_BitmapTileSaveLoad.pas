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

unit i_BitmapTileSaveLoad;

interface

uses
  i_BinaryData,
  i_Bitmap32Static;

type

  ///   <summary>��������� ���������� ��������� ������</summary>
  IBitmapTileLoader = interface
    ['{07D84005-DD59-4750-BCCE-A02330734539}']
    function Load(const AData: IBinaryData): IBitmap32Static;
  end;

  IBitmapTileSaver = interface
    ['{00853113-0F3E-441D-974E-CCBC2F5C6E10}']
    function Save(const ABitmap: IBitmap32Static): IBinaryData;
  end;

implementation

end.
 