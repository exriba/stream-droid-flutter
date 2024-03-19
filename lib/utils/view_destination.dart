enum ViewDestination {
  dashboard('Dashboard'),
  statistics('Statistics'),
  media('Media'),
  settings('Settings'),
  login('Login');

  const ViewDestination(this.label);
  final String label;
}
