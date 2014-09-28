let NumColumns = 10
let NumRows = 20
    
let StartingColumn = 4
let StartingRow = 0
    
let PreviewColumn = 12
let PreviewRow = 1

// Custom protocol
protocol SwiftrisDelegate {
    // Invoked when the current round of Swiftris ends
    func gameDidEnd(swiftris: SwifTris)
    
    // Invoked immediately after a new game has begun
    func gameDidBegin(swiftris: SwifTris)
    
    // Invoked when the falling shape has become part of the game board
    func gameShapeDidLand(swiftris: SwifTris)
    
    // Invoked when the falling shape has changed its location
    func gameShapeDidMove(swiftris: SwifTris)
    
    // Invoked when the falling shape has changed its location after being dropped
    func gameShapeDidDrop(swiftris: SwifTris)
    
    // Invoked when the game has reached a new level
    func gameDidLevelUp(swiftris: SwifTris)
}

class SwifTris{

    var blockArray:Array2D<Block>
    var nextShape:Shape?
    var fallingShape:Shape?
    /// The delegate will be notified of several events throughout the course of the game
    var delegate:SwiftrisDelegate?
    
    init() {
        fallingShape = nil
        nextShape = nil
        blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
    }
    
    func beginGame() {
        if (nextShape == nil) {
            nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
        }
    }
    
    /// Create a new shape before moving the falling shape
    func newShape() -> (fallingShape:Shape?, nextShape:Shape?) {
        fallingShape = nextShape
        nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
        fallingShape?.moveTo(StartingColumn, row: StartingRow)
        return (fallingShape, nextShape)
    }
}