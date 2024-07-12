abstract class HomeState {}

class HomeInitState extends HomeState {}

class GetCategoriesLoadingState extends HomeInitState {}
class GetCategoriesSuccessState extends HomeInitState {}
class GetCategoriesErrorState extends HomeInitState {}


class GetPeopleLoadingState extends HomeInitState {}
class GetPeopleSuccessState extends HomeInitState {}
class GetPeopleErrorState extends HomeInitState {}


class GetPlanetsLoadingState extends HomeInitState {}
class GetPlanetsSuccessState extends HomeInitState {}
class GetPlanetsErrorState extends HomeInitState {}



class GetFilmsLoadingState extends HomeInitState {}
class GetFilmsSuccessState extends HomeInitState {}
class GetFilmsErrorState extends HomeInitState {}


class GetSpeciesLoadingState extends HomeInitState {}
class GetSpeciesSuccessState extends HomeInitState {}
class GetSpeciesErrorState extends HomeInitState {}



class GetStarsShipsLoadingState extends HomeInitState {}
class GetStarsShipsSuccessState extends HomeInitState {}
class GetStarsShipsErrorState extends HomeInitState {}


class GetVehiclesLoadingState extends HomeInitState {}
class GetVehiclesSuccessState extends HomeInitState {}
class GetVehiclesErrorState extends HomeInitState {}

class GetFavoriteLoadingState extends HomeInitState {}
class GetFavoriteSuccessState extends HomeInitState {}
class GetFavoriteErrorState extends HomeInitState {}


class ChangeTabIndexSuccessState extends HomeInitState {}
class GetFavoritesSuccessState extends HomeInitState {}
class SaveFavoritesSuccessState extends HomeInitState {}


class ChangeNavIndexSuccessState extends HomeInitState {}
class GetSearchResultsSuccessState extends HomeInitState {}
class RefreshDataSearchResultsCountSuccessState extends HomeInitState {}
class RestartAllListsSuccessState extends HomeInitState {}




