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

unit i_StickToGrid;

interface

uses
  t_GeoTypes,
  i_Projection;

type
  IStickToGrid = interface
    ['{D6564C11-A30F-4A17-9391-54699060FF04}']
    function PointStick(
      const AProjection: IProjection;
      const ASourceLonLat: TDoublePoint
    ): TDoublePoint;
    function RectStick(
      const AProjection: IProjection;
      const ASourceRect: TDoubleRect
    ): TDoubleRect;
  end;

implementation

end.
