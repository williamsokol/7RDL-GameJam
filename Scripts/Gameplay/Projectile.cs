using Godot;

public class Projectile : Area2D
{
    [Export] private readonly float _moveSpeed;

    [Export] public float damage;
    private Vector2 _moveDirection = Vector2.Zero;

    public void Init(Vector2 position, float rotation)
    {
        Position = position;
        RotationDegrees = rotation;
    }

    public override void _Process(float delta) => CalculateDirection();

    public override void _PhysicsProcess(float delta)
    {
        Position += (_moveDirection * _moveSpeed * GetPhysicsProcessDeltaTime());
    }

    private void CalculateDirection()
    {
        _moveDirection = new Vector2(Mathf.Sin(Rotation), -Mathf.Cos(Rotation));
        _moveDirection = _moveDirection.Normalized();
    }

    /*
        Need to handle the destruction of these objects soon.
        Depends on how the game is going to work, but they could be destroy
        once they leave the screen or once they travel further than a specified range.
    */
}
