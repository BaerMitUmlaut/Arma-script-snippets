_caller = _this select 0;

_gpsItem = "";

{	//this works with Vanilla gear (no GPS, GPS, UAV Terminals), cTab and BWMod's NaviPad
	if (getText (configFile >> "cfgWeapons" >> _x >> "simulation") == "ItemGPS"
		|| inheritsFrom (configFile >> "cfgWeapons" >> _x) == (configFile >> "cfgWeapons" >> "ItemGPS")
		|| inheritsFrom (configFile >> "cfgWeapons" >> _x) == (configFile >> "cfgWeapons" >> "UAVTerminal_base")) then {
		_gpsItem = _x;
	};
} foreach assignedItems _caller;

if (!("" == _gpsItem)) then {_caller unlinkItem _gpsItem};
_caller linkItem "B_UavTerminal";

_caller action ["UAVTerminalOpen", _caller];
waitUntil {!(isNull (findDisplay 160))};
waitUntil {isNull (findDisplay 160)};

_caller unlinkItem "B_UavTerminal";
if (!("" == _gpsItem)) then {_caller linkItem _gpsItem};
