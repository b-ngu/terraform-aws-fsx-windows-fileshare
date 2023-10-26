output "fsx_id" {
  description = "The ID of the FSx Windows File Server"
  value       = aws_fsx_windows_file_system.main.id
}

output "fsx_dns_name" {
  description = "The DNS name for the FSx Windows File Server"
  value       = aws_fsx_windows_file_system.main.dns_name
}