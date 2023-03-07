using Godot;
using System;

public class LevelManager : Node2D
{
    [Export]
    public Vector2 mapSize;
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        mapSize = GetViewportRect().Size;
        GD.Print("ready");
    }

    //  // Called every frame. 'delta' is the elapsed time since the previous frame.
    //  public override void _Process(float delta)
    //  {
    //      
    //  }
}
