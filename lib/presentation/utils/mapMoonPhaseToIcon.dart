String mapMoonPhaseToIcon(String phase) {
  switch (phase) {
    case 'New Moon':
      return 'assets/wi-moon-new.svg';
    case 'Waxing Crescent':
      return 'assets/wi-moon-new.svg';
    case 'First Quarter':
      return 'assets/wi-moon-first-quarter.svg';
    case 'Waxing Gibbous':
      return 'assets/wi-moon-alt-waxing-gibbous-2.svg';
    case 'Full Moon':
      return 'assets/wi-moon-new.svg';
    case 'Waning Gibbous':
      return 'assets/wi-moon-waning-gibbous-1.svg';
    case 'Last Quarter':
      return 'assets/wi-moon-third-quarter.svg';
    case 'Waning Crescent':
      return 'assets/wi-moon-waning-crescent-2.svg';
    default:
      return 'assets/wi-moon-new.svg';
  }
}
