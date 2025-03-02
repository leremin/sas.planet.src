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

unit i_TileDownloadSubsystem;

interface

uses
  Types,
  i_NotifierOperation,
  i_MapVersionInfo,
  i_DownloadRequest,
  i_TileRequestTask,
  i_TileDownloaderState;

type
  ITileDownloadSubsystem = interface
    ['{06FFC386-43A0-4308-B294-58F8CF429BCB}']
    function GetRequestTask(
      const ASoftCancelNotifier: INotifierOneOperation;
      const ACancelNotifier: INotifierOperation;
      const AOperationID: Integer;
      const AFinishNotifier: ITileRequestTaskFinishNotifier;
      const AXY: TPoint;
      const AZoom: Byte;
      const AVersion: IMapVersionInfo;
      const ACheckTileSize: Boolean
    ): ITileRequestTask;

    function GetRequest(
      const AXY: TPoint;
      const AZoom: Byte;
      const AVersion: IMapVersionInfo
    ): IDownloadRequest;

    procedure Download(
      const ATileRequestTask: ITileRequestTask
    );

    function GetState: ITileDownloaderStateChangeble;
    property State: ITileDownloaderStateChangeble read GetState;
  end;

implementation

end.
