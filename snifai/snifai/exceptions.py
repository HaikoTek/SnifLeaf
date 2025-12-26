class SnifaiException(Exception):
    """Base exception for Snifai."""

class OperationalException(SnifaiException):
    """Exception for operational errors."""
    
class ConfigurationError(OperationalException):
    """Exception for configuration-related errors."""