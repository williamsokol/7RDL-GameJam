using Godot;
using System;

public class Custom : Node
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";

    public float test = .2f;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {

    }
    public float map(float s, float a1, float a2, float b1, float b2)
    {
        return b1 + (s - a1) * (b2 - b1) / (a2 - a1);
    }
    public float Test()
    {
        return .1f;
    }
    //  // Called every frame. 'delta' is the elapsed time since the previous frame.
    //  public override void _Process(float delta)
    //  {
    //      
    //  }
}
