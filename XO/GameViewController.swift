import UIKit

class GameViewController: UIViewController {
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet weak var selectGameButton: UIButton!

    let firstPlayerMarkViewPrototype: XView = {
        let markView = XView()
        markView.lineColor = .green
        markView.lineWidth = 5
        return markView
    }()

    let secondPlayerMarkViewPrototype: OView = {
        let markView = OView()
        markView.lineColor = .red
        markView.lineWidth = 10
        return markView
    }()

    let gameboard = Gameboard()
    var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    lazy var referee = Referee(gameboard: self.gameboard)
    var isComputerVsHuman: Bool = false
    var isBlindPlayerGame: Bool = false
    var firstPlayerMotion: [GameboardPosition] = []
    var secondPlayerMotion: [GameboardPosition] = []
    let maxCountMotion = 5 //GameboardSize.rows * GameboardSize.columns

    override func viewDidLoad() {
        super.viewDidLoad()
        if isComputerVsHuman {
            secondPlayerTurnLabel.text = "2st computer"
        }
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            if self.gameboard.isAvailablePositions(at: position) {
                if self.isBlindPlayerGame {
                    if self.firstPlayerMotion.count < self.maxCountMotion {
                        self.firstPlayerMotion.append(position)
                        self.currentState = BlindPlayerInputState(player: .first, gameViewController: self, markViewPrototype: self.firstPlayerMarkViewPrototype.copy())
                        self.currentState.addMark(at: position)
                        if self.firstPlayerMotion.count == self.maxCountMotion {
                            self.gameboard.clear()
                            self.gameboardView.clear()
                            self.currentState = BlindPlayerInputState(player: .second, gameViewController: self, markViewPrototype: self.secondPlayerMarkViewPrototype.copy())
                        }
                    } else if self.secondPlayerMotion.count < self.maxCountMotion {
                        self.secondPlayerMotion.append(position)
                        self.currentState = BlindPlayerInputState(player: .second, gameViewController: self, markViewPrototype: self.secondPlayerMarkViewPrototype.copy())
                        self.currentState.addMark(at: position)
                        if self.secondPlayerMotion.count == self.maxCountMotion {
                            self.gameboard.clear()
                            self.gameboardView.clear()
                            self.secondPlayerTurnLabel.isHidden = true
                            self.winnerLabel.text = "Watch the game"
                            self.winnerLabel.isHidden = false
                            Invoker().work(gameViewController: self)
                        }
                    }
                } else {
                    self.currentState.addMark(at: position)
                    self.switchToNextState()
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentState = PlayerInputState(player: .first, gameViewController: self, markViewPrototype: firstPlayerMarkViewPrototype.copy())
    }

    private func switchToNextState() {
        guard currentState.isCompleted else { return }
        if let winner = referee.determineWinner() {
            currentState = GameFinishedState(player: winner, gameViewController: self)
        } else if !gameboard.gotAvailablePositions {
            currentState = GameFinishedState(player: nil, gameViewController: self)
        } else if let nextPlayer = currentState.currentPlayer?.next {
            let markView: MarkView = nextPlayer == .first ? firstPlayerMarkViewPrototype.copy() : secondPlayerMarkViewPrototype.copy()
            if isComputerVsHuman, nextPlayer == .second {
                currentState = ComputerInputState(player: nextPlayer, gameViewController: self, markViewPrototype: markView)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.switchToNextState()
                }
            } else {
                currentState = PlayerInputState(player: nextPlayer, gameViewController: self, markViewPrototype: markView)
            }
        }
    }

    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Logger.shared.did(action: .restartGame)
        gameboard.clear()
        gameboardView.clear()
        currentState = PlayerInputState(player: .first, gameViewController: self, markViewPrototype: firstPlayerMarkViewPrototype.copy())
        firstPlayerMotion = []
        secondPlayerMotion = []
    }

    @IBAction func selectGameButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

