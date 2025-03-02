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

unit i_MapMovingConfig;

interface

uses
  i_ConfigDataElement;

type
  IMapMovingConfig = interface(IConfigDataElement)
    ['{A322104E-A247-4EB3-83F6-C897F64E764C}']
    //�������� �������
    function GetAnimateMove: Boolean;
    procedure SetAnimateMove(AValue: Boolean);
    property AnimateMove: Boolean read GetAnimateMove write SetAnimateMove;

    function GetAnimateMoveTime: Cardinal;
    procedure SetAnimateMoveTime(AValue: Cardinal);
    property AnimateMoveTime: Cardinal read GetAnimateMoveTime write SetAnimateMoveTime;

    function GetAnimateMaxStartSpeed: Cardinal;
    procedure SetAnimateMaxStartSpeed(AValue: Cardinal);
    property AnimateMaxStartSpeed: Cardinal read GetAnimateMaxStartSpeed write SetAnimateMaxStartSpeed;

    function GetAnimateMinStartSpeed: Cardinal;
    procedure SetAnimateMinStartSpeed(AValue: Cardinal);
    property AnimateMinStartSpeed: Cardinal read GetAnimateMinStartSpeed write SetAnimateMinStartSpeed;
  end;

implementation

end.
