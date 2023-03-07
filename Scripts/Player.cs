using Godot;

public class Player : KinematicBody2D
{
    [Export] private readonly float _acceleration;
    [Export] private readonly float _maxVelocity;
    [Export] private readonly float _drag;
    [Export] private readonly bool _debugInfo;
    [Export] private readonly PackedScene _projectile;

    // Debug Stuff
    private Label _velocityLabel;
    private Line2D _mouseLine;
    // -----------

    private Vector2 _inputVector = Vector2.Zero;
    private Vector2 _velocity = Vector2.Zero;
    private Vector2 _mouseDirection = Vector2.Zero;

    #region Godot Methods
    public override void _Ready()
    {
        _velocityLabel = GetNode<Label>("Debug/Velocity");
        _mouseLine = GetNode<Line2D>("Debug/MouseLine");
    }

    public override void _Process(float delta)
    {
        FetchInput();
        CalculateVelocity();
        CalculateMouseAngle();

        ShowDebugInfo();
    }

    public override void _PhysicsProcess(float delta) => HandleMovement();

    #endregion

    #region Movement and Shooting
    private void FetchInput()
    {
        _inputVector = Vector2.Zero;

        _inputVector.x = Input.IsActionPressed("MoveLeft") ? -1.0f : _inputVector.x;
        _inputVector.x = Input.IsActionPressed("MoveRight") ? 1.0f : _inputVector.x;

        _inputVector.y = Input.IsActionPressed("MoveUp") ? -1.0f : _inputVector.y;
        _inputVector.y = Input.IsActionPressed("MoveDown") ? 1.0f : _inputVector.y;

        if (Input.IsActionJustPressed("Fire"))
        {
            FireProjectile();
        }
    }

    private void HandleMovement() => MoveAndSlide(_velocity);

    private void FireProjectile()
    {
        Projectile p = _projectile.Instance<Projectile>();

        p.Init(Position, CalculateMouseAngle());
        GetTree().Root.AddChild(p);
    }
    #endregion

    #region Calculations
    private void CalculateVelocity()
    {
        _velocity = new Vector2(Mathf.Clamp(_velocity.x, -_maxVelocity, _maxVelocity),
            Mathf.Clamp(_velocity.y, -_maxVelocity, _maxVelocity));

        _velocity += _inputVector.Normalized() * _acceleration * GetPhysicsProcessDeltaTime();

        if (_inputVector.y == 0)
        {
            _velocity.y = ApplyDrag(ref _velocity.y);
        }

        if (_inputVector.x == 0)
        {
            _velocity.x = ApplyDrag(ref _velocity.x);
        }
    }

    private float ApplyDrag(ref float coord)
    {
        /*_velocity.x = Mathf.MoveToward(_velocity.x, 0.0f, _drag * GetProcessDeltaTime());
        _velocity.y = Mathf.MoveToward(_velocity.y, 0.0f, _drag * GetProcessDeltaTime());*/

        return Mathf.MoveToward(coord, 0.0f, _drag * GetProcessDeltaTime());
    }

    private float CalculateMouseAngle()
    {
        _mouseDirection = GetGlobalMousePosition() - Position;

        float angleRads = Mathf.Atan2(_mouseDirection.y, _mouseDirection.x);
        float angleDegs = Mathf.Rad2Deg(angleRads);

        // 90 Degree offset is necessary to get the correct angle
        return angleDegs + 90.0f;
    }
    #endregion

    private void ShowDebugInfo()
    {
        if (!_debugInfo) return;

        _velocityLabel.Text = "Velocity: " + _velocity.ToString("0.0");
        _mouseLine.SetPointPosition(1, _mouseDirection.Normalized() * 100.0f);
    }
}
