from django.shortcuts import render
from .models import Certificate
from django.http import HttpResponse

def verify_certificate(request):
    # Default context for the template
    context = {'verification_result': None}

    if request.method == 'POST':
        # Get the hash submitted by the user
        submitted_hash = request.POST.get('ipfs_hash', '').strip()

        if submitted_hash:
            try:
                # Attempt to find a matching certificate in the database
                certificate = Certificate.objects.get(ipfs_hash=submitted_hash)

                # Verification SUCCESS
                context['verification_result'] = {
                    'status': 'Verified',
                    'message': 'This certificate is **AUTHENTIC** and was successfully verified.',
                    'certificate_details': certificate,
                    'is_valid': True
                }

            except Certificate.DoesNotExist:
                # Verification FAILURE
                context['verification_result'] = {
                    'status': 'Invalid',
                    'message': 'The hash does not match any certificate in our records. This certificate is **NOT AUTHENTIC**.',
                    'is_valid': False
                }

            except Exception as e:
                # Catch other potential errors
                context['verification_result'] = {
                    'status': 'Error',
                    'message': f'An error occurred during verification: {e}',
                    'is_valid': False
                }
        else:
             context['verification_result'] = {
                'status': 'Error',
                'message': 'Please enter a certificate hash to verify.',
                'is_valid': False
            }

    # Render the template with the verification result
    return render(request, 'core/verification_form.html', context)