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

unit t_GeoTypes;

interface

uses
  Types;

type
  TPointRounding = (prClosest, prToTopLeft, prToBottomRight);
  TRectRounding = (rrClosest, rrOutside, rrInside, rrToTopLeft);
  TRectWithPolygonIntersection = (rwpNoIntersect, rwpIntersectPartial, rwpRectInPolygon, rwpPolygonInRect);

  PDoublePoint = ^TDoublePoint;

  TDoublePoint = packed record
    X, Y: Double;
  end;

  TDoubleRect = packed record
    case Integer of
      0: (Left, Top: Double;
        Right, Bottom: Double);
      1: (TopLeft, BottomRight: TDoublePoint);
  end;


  PPointArray = ^TPointArray;
  TPointArray = array [0..0] of TPoint;
  PArrayOfPoint = ^TArrayOfPoint;
  TArrayOfPoint = array of TPoint;

  PDoublePointArray = ^TDoublePointArray;
  TDoublePointArray = array [0..0] of TDoublePoint;

implementation

end.
