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

unit i_AppearanceOfMarkFactory;

interface

uses
  t_Bitmap32,
  i_MarkPicture,
  i_Appearance;

type
  IAppearanceOfMarkFactory = interface
    ['{8AE2CA8B-59EC-43CE-A9FB-D5D081876369}']
    function CreatePointAppearance(
      const ATextColor: TColor32;
      const ATextBgColor: TColor32;
      const AFontSize: Integer;
      const APicName: string;
      const APic: IMarkPicture;
      const AMarkerSize: Integer
    ): IAppearance;
    function CreateLineAppearance(
      const ALineColor: TColor32;
      const ALineWidth: Integer
    ): IAppearance;
    function CreatePolygonAppearance(
      const ALineColor: TColor32;
      const ALineWidth: Integer;
      const AFillColor: TColor32
    ): IAppearance;
  end;

implementation

end.
