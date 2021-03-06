# Overtime App

## Key requirement: company needs documentation that salaried employees did or did not get overtime each week

## Models
- x Post -> date:date rationale:text
- x User -> Devise
- x AdminUser -> STI
- x AuditLog

## Features:
- x Approval Workflow
- x SMS Sending -> link to approval or overtime input -> integrate with Heroku scheduler
- x Administrate admin dashboard
- x Block non-admin and guest users
- x Email summary to managers for approval
- x Needs to be documented if employee did not log overtime
- x Create audit log for each text message
- x Update audit log end date when confirmed
- x Update audit log status when overtime request rejected
- x Update buttons on employee homepage (mobile-friendly, full timespan, sort order)
- x Remove 'Entries' for admins
- x Fix admin dashboard bug
- x Implement new relic for keeping site alive

## UI:
- x Bootstrap -> formatting
- x Glyphicons

## TODOS: