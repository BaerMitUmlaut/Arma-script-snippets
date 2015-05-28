private ["_file", "_setting", "_type", "_return", "_string", "_arrString", "_posSetting", "_posValue", "_numberCodes"];

_file = _this select 0;
_setting = _this select 1;
_type = _this select 2; //"SCALAR", "BOOL" or "STRING"
_return = 0;

_string = preprocessFile _file;
_arrString = toArray _string;

_posSetting = (_string find _setting);
if (_posSetting == -1) exitWith {"Error: Setting not found."};

_posValue = _posSetting + (count _setting);
while {((_arrString select _posValue) == 32) || ((_arrString select _posValue) == 61)} do {
	_posValue = _posValue + 1;
};

switch (_type) do {
	case "SCALAR": {
		_numberCodes = [49,50,51,52,53,54,55,56,57,48];
		_return = 0;
		while {(_arrString select _posValue) in _numberCodes} do {
			_return = _return * 10 + ((_arrString select _posValue) - 48);
			_posValue = _posValue + 1;
		};
		if ((_arrString select _posValue) == 46) then {	
			_posValue = _posValue + 1;
			_decimal = 0.1;
			while {(_arrString select _posValue) in _numberCodes} do {
				_return = _return + ((_arrString select _posValue) - 48) * _decimal;
				_decimal = _decimal / 10;
				_posValue = _posValue + 1;
			};
		};
	};
	case "BOOL": {
		if ([[(_arrString select _posValue), (_arrString select _posValue + 1), (_arrString select _posValue + 2), (_arrString select _posValue + 3)], [116,114,117,101]] call BIS_fnc_areEqual) then {
			_return = true;
		} else {
			_return = false;
		};
	};
	case "STRING": {
		if ((_arrString select _posValue) == 34) then {
			_posValue = _posValue + 1;
			_return = "";
			while {!((_arrString select _posValue) == 34)} do {
				_return = _return + (toString [(_arrString select _posValue)]);
				_posValue = _posValue + 1;
			};
		} else {
			_return = "";
		};
	};
};
_return
