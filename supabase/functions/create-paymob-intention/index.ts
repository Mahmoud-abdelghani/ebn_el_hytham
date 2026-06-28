import "@supabase/functions-js/edge-runtime.d.ts";

Deno.serve(async (req) => {
  try {

    const body = await req.json();

    const amount = body.amount;

    const response = await fetch(
      "https://accept.paymob.com/v1/intention/",
      {
        method: "POST",

        headers: {
          "Content-Type": "application/json",

          "Authorization":
            `Token ${Deno.env.get("PAYMOB_SECRET_KEY")}`,
        },

        body: JSON.stringify({
          amount: amount * 100,

          currency: "EGP",

          payment_methods: [
            5752424, // حط Integration ID الحقيقي
          ],

          notification_url:
            "https://accept.paymob.com/api/acceptance/post_pay",

          items: [
            {
              name: "Graduation Project",
              amount: amount * 100,
              quantity: 1,
            }
          ],

          billing_data: {
            first_name: "Mahmoud",
            last_name: "User",
            email: "test@test.com",
            phone_number: "+201000000000",
          },

          special_reference:
            crypto.randomUUID(),

        }),
      },
    );

    const data =
      await response.json();

    if (!response.ok) {
      return Response.json(
        data,
        {
          status:
            response.status,
        },
      );
    }

    return Response.json({
      client_secret:
        data.client_secret,
    });

  } catch (e) {

    return Response.json(
      {
        error:
          String(e),
      },

      {
        status: 500,
      },
    );
  }
});