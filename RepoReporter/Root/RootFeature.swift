E.

import ComposableArchitecture

struct RootState {
  var userState = UserState()
  var repositoryState = RepositoryState()
}

enum RootAction {
  case userAction(UserAction)
  case repositoryAction(RepositoryAction)
}

struct RootEnvironment { }

// swiftlint:disable trailing_closure
let rootReducer = Reducer<
  RootState,
  RootAction,
  SystemEnvironment<RootEnvironment>
>.combine(
  userReducer.pullback(
    state: \.userState,
    action: /RootAction.userAction,
    environment: { _ in .live(environment: UserEnvironment(userRequest: userEffect)) }),
  repositoryReducer.pullback(
    state: \.repositoryState,
    action: /RootAction.repositoryAction,
    environment: { _ in
       .live(
        environment:
          RepositoryEnvironment(repositoryRequest: repositoryEffect))
   })

)
// swiftlint:enable trailing_closure
